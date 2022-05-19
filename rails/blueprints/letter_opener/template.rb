def apply_self!
    if yes?("Would you like to install Letter Opener?", :blue)
      gem_group :development do
        gem "letter_opener"
      end
      run "bundle install"
    end
  end
  
  apply_self!
  