def apply_self!
  if yes?("Would you like to use Rspec for testing?", :blue)
    FileUtils.rm_rf("test")
    gem 'rubocop-rspec', require: false
    gem_group :development, :test do
      gem 'rspec-rails'
      gem 'factory_bot_rails'
      gem 'shoulda'
    end
    run "bundle install"
    generate 'rspec:install'
    gsub_file 'spec/rails_helper.rb', "config.fixture_path = \"\#{::Rails.root}/spec/fixtures\"", "config.include FactoryBot::Syntax::Methods" 
    devise_config
    empty_directory 'spec/models'
    empty_directory 'spec/controllers'
    empty_directory 'spec/factories'
    graphql_config
    content = " - rubocop-rspec"
    insert_into_file '.rubocop.yml', content, after: /require:\n/
  end
end

def devise_config 
  if yes?("Should Rspec account for Devise?", :blue)
    gsub_file 'spec/rails_helper.rb', "config.filter_rails_from_backtrace", "config.filter_rails_from_backtrace\n\tconfig.include Devise::Test::ControllerHelpers, type: :controller"
  end
end

def graphql_config
  if yes?("Should Rspec account for GraphQl", :blue)
    empty_directory 'spec/graphql/mutations'
    empty_directory 'spec/graphql/queries'
    copy_file "blueprints/rspec/schema_spec", "spec/graphql/schema_spec.rb"
  end
end

apply_self!
