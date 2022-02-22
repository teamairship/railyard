# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.2'

group :development, :test do
  gem 'bundle-audit'
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'dotenv-rails'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'guard'
  gem 'guard-brakeman'
  gem 'guard-minitest'
  gem 'guard-rubocop'
  gem 'guard-shell'
  gem 'guard-spring'
  gem 'letter_opener'
  gem 'pry'
  gem 'pry-byebug'
  gem 'pry-rails'
  gem 'rubocop'
  gem 'rubocop-performance'
  gem 'rubocop-rails'
end

group :development do
  gem 'foreman'
  gem 'listen'
  gem 'overcommit'
  gem 'spring'
  gem 'spring-watcher-listen'
  gem 'web-console'
end

group :test do
  gem 'capybara'
  gem 'database_cleaner'
  gem 'minitest-ci'
  gem 'minitest-retry'
  gem 'selenium-webdriver'
  gem 'webdrivers'
end

gem 'audited', '~> 5.0'
gem 'bootsnap', '>= 1.4.4', require: false
gem 'bugsnag'
gem 'cssbundling-rails'
gem 'jsbundling-rails'
gem 'json-jwt', '~> 1.13'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 4.1'
gem 'pundit', '~> 2.1'
gem 'rails', '~> 7.0.0'
gem 'sassc-rails', '~> 2.1'
gem 'stimulus-rails'
gem 'turbo_flash'
gem 'turbo-rails'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
gem 'webpacker', '~> 5.0'
