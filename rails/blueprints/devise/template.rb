def apply_self!
  if yes?("Would you like to install Devise?")
    gem "devise"
    run "bundle install"

    generate "devise:install"
    model_name = ask("What would you like the user model to be called? [user]")
    model_name = "user" if model_name.blank?
    generate "devise", model_name
  end
end

apply_self!
