def apply_self!
  if yes?("Would you like to add an API Versioner?", :blue)
    copy_file "blueprints/api_versioner/versioner_generator.rb", 'lib/generators/versioner/versioner_generator.rb'
    copy_file "blueprints/api_versioner/USAGE", 'lib/generators/versioner/USAGE'
    if yes?("Initiate v1 now?", :blue)
      # API
      empty_directory "app/controllers/api/v1"
      
      # Routes
      insert_into_file 'config/routes.rb', before: /^end/ do  
        "\n\s\sconcern :api_version do\n\s\s\s\s# i.e. resources :users\n\s\send\n\s\snamespace :api, defaults: { format: :json } do\n\s\s\s\snamespace :v1 do\n\s\s\s\s\s\sconcerns :api_version\n\s\s\s\send\n\s\send\n"
      end
      # Tests
      say("Will you be using MiniTest or RSpec?", :blue)
      say("(0) MiniTest", :blue)
      say("(1) RSpec", :blue)
      testing = ask("MiniTest or RSpec:", :blue, limited_to: %w[0 1])
      if testing = 0
        empty_directory "test/controllers/api/v1"
      else
        empty_directory "spec/controllers/api/v1"
      end
      
      puts "===========================================================".green
      say("v1 generated! Generate new API versions by running `rails generate versioner` in the console", :green)
      puts "===========================================================".green
    else
      puts "===========================================================".green
      say("Versioner has been added! Generate new API versions by running `rails generate versioner` in the console", :green)
      puts "===========================================================".green
    end
  end
end

apply_self!
