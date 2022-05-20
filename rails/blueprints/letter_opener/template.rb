def apply_self!
    if yes?("Would you like to install Letter Opener?", :blue)
      gem_group :development do
        gem "letter_opener"
      end
      run "bundle install"
      insert_into_file 'config/environments/development.rb', "\n\tconfig.action_mailer.perform_deliveries = true", after: "config.action_mailer.delivery_method = :letter_opener"

    end
  end
  
  apply_self!
  