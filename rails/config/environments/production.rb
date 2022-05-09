uncomment_lines "config/environments/production.rb", /config\.force_ssl = true/
gsub_file "config/environments/production.rb", /\bSTDOUT\b/, "$stdout"
gsub_file "config/environments/production.rb",
          "config.force_ssl = true",
          'config.force_ssl = ENV["RAILS_FORCE_SSL"].present?'

insert_into_file "config/environments/production.rb", after: /# config\.action_mailer\.raise_deliv.*\n/ do
  <<-RUBY
  # Production email config
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.default_url_options = { host: ENV['RAILS_HOST'], protocol: ENV['RAILS_PROTOCOL'] }
  RUBY
end
