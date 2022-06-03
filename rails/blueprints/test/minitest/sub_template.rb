def apply_self!
  gem_group :development, :test do
    gem 'guard-minitest'
    gem 'factory_bot_rails'
  end

  gem_group :test do
    gem 'minitest-ci'
    gem 'minitest-retry'
  end

  run 'bundle install'

  copy_file 'test/test_helper.rb', force: true
  copy_file 'test/support/circleci.rb'
  copy_file 'test/support/cleaner.rb'
  copy_file 'test/support/factorybot.rb'
  copy_file 'test/support/faker.rb'
  copy_file 'test/support/mailer.rb'
  copy_file 'test/support/rails.rb'
  copy_file 'test/support/retry.rb'
  copy_file 'test/support/simplecov.rb'
end

apply_self!
