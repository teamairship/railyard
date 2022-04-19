source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.1.0"

# Specify your gem's dependencies in railscaptain.gemspec
gemspec

gem 'bootsnap', require: false
gem 'bugsnag'
gem 'pg'
gem 'overcommit'

group :development, :test do
  gem 'codeclimate-test-reporter', '~> 1.0.0'
  gem "debug", platforms: %i[mri mingw x64_mingw]
  gem 'faker', '~> 2.11.0'
  gem 'guard'
  gem 'guard-brakeman'
  gem 'guard-minitest'
  gem 'guard-rubocop'
  gem 'guard-shell'
  gem 'guard-spring'
  gem 'simplecov'
end
