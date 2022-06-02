def apply_self!
    if yes?("Would you like to install Letter Opener?", :blue)
      gem_group :development do
        gem "letter_opener"
      end
      run "bundle install"
      environment "config.action_mailer.perform_deliveries = true", env: 'development'
    end
  end
  
  apply_self!
  