copy_file 'config/initializers/generators.rb'
copy_file 'config/initializers/rotate_log.rb'
copy_file 'config/initializers/bugsnag.rb'

apply 'config/environments/development.rb'
apply 'config/environments/production.rb'
apply 'config/environments/test.rb'
