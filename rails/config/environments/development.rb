mailer_regex = /config\.action_mailer\.raise_delivery_errors = false\n/

comment_lines "config/environments/development.rb", mailer_regex
insert_into_file "config/environments/development.rb", after: mailer_regex do
  <<-RUBY
  # Ensure mailer works in development.
  config.action_mailer.delivery_method = :letter_opener
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.default_url_options = { host: ENV['RAILS_HOST'], protocol: ENV['RAILS_PROTOCOL'] }
  RUBY
end

gsub_file "config/environments/development.rb",
          "join('tmp', 'caching-dev.txt')",
          'join("tmp/caching-dev.txt")'
