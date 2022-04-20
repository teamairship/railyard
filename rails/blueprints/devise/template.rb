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
      generate :migration, "add_role_to_devise role:integer"

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
  end
end

apply_self!
