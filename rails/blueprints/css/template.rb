def apply_self!
  if yes?("Would you like to use tailwind?", :blue)
    gem "tailwindcss-rails"
    run "bundle install"

    run "rails tailwindcss:install"
  end
end

apply_self!
