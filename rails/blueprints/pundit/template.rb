def apply_self!
  if yes?("Would you like to install Pundit?", :blue)
    gem "pundit"
    run "bundle install"
    generate "pundit:install"
  end
end

apply_self!
