def apply_self!
  if yes?("Would you like to install Simple Form?")
    gem "simple_form"
    run "bundle install"

    if yes?("Do you use Bootstrap?")
      generate "simple_form:install --bootstrap"
    elsif yes?("Do you use Tailwind?")
      generate "simple_form:install"
      gem "simple_form-tailwind"
      run "bundle install"
      generate "simple_form:tailwind:install"
    end
  end
end

apply_self!
