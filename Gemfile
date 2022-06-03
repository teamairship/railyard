source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.1.0"

gem 'activesupport'
gem 'dotenv'
gem 'terminal-table'
gem 'thor', '~> 1.0'
gem 'colorize'

group :development, :test do
  gem "debug", platforms: %i[mri mingw x64_mingw]
  gem 'faker', '~> 2.11.0'
  gem 'guard'
  gem 'guard-brakeman'
  gem 'guard-rubocop'
  gem 'guard-shell'
  gem 'guard-spring'
end
