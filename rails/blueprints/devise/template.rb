def apply_self!
  if yes?("Would you like to install Devise?", :blue)
    gem "devise"
    run "bundle install"

    generate "devise:install"
    environment "config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }", env: 'development'
    gsub_file 'config/initializers/devise.rb', /  # config.secret_key = .+/, '  config.secret_key = Rails.application.credentials.secret_key_base'
    route '  root to: "home#index"'
    insert_into_file 'app/views/layouts/application.html.erb', "    <p class=\"notice\"><%= notice %></p>\n    <p class=\"alert\"><%= alert %></p>\n", after: /  <body>\n/

    model_name = ask("What would you like the user model to be called? (default: user)", :blue)
    model_name = "user" if model_name.blank?
    generate "devise", model_name

    if yes?("Would you like to generate roles for your Devise users?", :blue)
      generate :migration, "add_role_to_#{model_name.pluralize} role:integer"

      roles = ask("Press return to use the default roles (admin user). Enter the roles in snake_case, separated by spaces, and press return.", :blue)
      roles = "admin user" if roles.blank?

      content = "\n  enum role: {\n"
      roles.split(' ').each_with_index do |role, index|
        content += "    #{role}: #{index},\n" unless index + 1 == roles.split(" ").count
        content += "    #{role}: #{index}\n" if index + 1 == roles.split(" ").count
      end
      content += "  }\n"

      insert_into_file 'app/models/user.rb', "#{content}", before: /^end/
    end

    if yes?("Would you like to generate the views for Devise?", :blue)
      generate "devise:views"
    end
  elsif yes?("Would you like to use JWT authentication?", :blue)
    gem "jwt"
    gem "bcrypt"
    run "bundle install"

    model_name = ask("What would you like the user model to be called? (default: user)", :blue)
    model_name = "user" if model_name.blank?
    generate :resource, "#{model_name} email password --no-test-framework"

    user_model_content = "  require \"securerandom\"\n\n  has_secure_password\n"
    insert_into_file "app/models/#{model_name}.rb", "#{user_model_content}", before: /^end/

    user_controller_content = "  skip_before_action :authenticate_request, only: [:create]\n"
    insert_into_file "app/controllers/#{model_name}s_controller.rb", "#{user_controller_content}", before: /^end/

    create_file 'app/controllers/concerns/json_web_token.rb'
    json_web_token_content
    application_controller_content
    create_file 'app/controllers/authentication_controller.rb'
    authentication_controller_content

    route "  post '/auth/login', to: 'authentication#login'"
  end
end

def json_web_token_content
append_file 'app/controllers/concerns/json_web_token.rb' do
<<-RUBY
# frozen_string_literal: true

require "jwt"
module JsonWebToken
  extend ActiveSupport::Concern
  SECRET_KEY = Rails.application.secret_key_base

  def jwt_encode(payload, exp = 7.days.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload, SECRET_KEY)
  end

  def jwt_decode(token)
    decoded = JWT.decode(token, SECRET_KEY)[0]
    HashWithIndifferentAccess.new decoded
  end
end
RUBY
end
end

def application_controller_content
insert_into_file "app/controllers/application_controller.rb", before: /^end/ do
  <<-RUBY
  include JsonWebToken

  before_action :authenticate_request

  private
    def authenticate_request
      header = request.headers["Authorization"]
      header = header.split(" ").last if header
      decoded = jwt_decode(header)
      @current_user = User.find(decoded[:user_id])
    end
  RUBY
  end
end

def authentication_controller_content
append_file 'app/controllers/authentication_controller.rb' do
<<-RUBY
# frozen_string_literal: true

class AuthenticationController < ApplicationController
  skip_before_action :authenticate_request

  def login
    @user = User.find_by_email(params[:email])
    if @user&.authenticate(params[:password])
      token = jwt_encode(user_id: @user.id)
      render json: { token: token }, status: :ok
    else
      render json: { error: 'unauthorized' }, status: :unauthorized
    end
  end
end
RUBY
end
end

apply_self!
