insert_into_file "config/environments/test.rb", after: /config\.action_mailer\.delivery_method = :test\n/ do
  <<-RUBY
  # Ensure mailer works in test
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.default_url_options = { host: ENV['RAILS_HOST'] }
  config.action_mailer.asset_host = ENV['RAILS_HOST']
  RUBY
end
