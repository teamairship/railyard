def apply_self!
  if yes?("Would you like to install Simple Form?", :blue)
    gem "simple_form"
    run "bundle install"

    if yes?("Do you use Tailwind for Simple Form?", :blue)
      generate "simple_form:install"
      gem "simple_form-tailwind"
      run "bundle install"
      generate "simple_form:tailwind:install"
    elsif yes?("Do you use Bootstrap for Simple Form?", :blue)
      generate "simple_form:install --bootstrap"
    else
      generate "simple_form:install"
    end
  end
end

apply_self!
