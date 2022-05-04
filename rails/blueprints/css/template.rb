def apply_self!
  if yes?("Would you like to use tailwind?")
    gem "tailwindcss-rails"
    run "bundle install"

    ask("*** NOTE: If you are prompted to 'overwrite' ./bin/dev, press Y. Press enter to continue. ***", :blue)
    run "rails tailwindcss:install"
  end
end

apply_self!
