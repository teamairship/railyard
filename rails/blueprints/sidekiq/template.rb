def apply_self!
  if yes?('Would you like to set up sidekiq?', :blue)
    gem "sidekiq"
    run "bundle install"

    environment "config.active_job.queue_adapter = :sidekiq"
    insert_into_file 'Procfile.dev', "redis: redis-server\n", after: /js: yarn build --watch\n/
    insert_into_file 'Procfile.dev', "worker: bundle exec sidekiq -c 5 -q default\n", after: /redis: redis-server\n/

    create_file 'config/initializers/sidekiq.rb'
    insert_into_file 'config/initializers/sidekiq.rb', "# frozen_string_literal: true\n\nrequire 'sidekiq/web'\n"
    insert_into_file 'config/initializers/sidekiq.rb', "\nSidekiq.configure_server do |config|\n  config.redis = { ssl_params: { verify_mode: OpenSSL::SSL::VERIFY_NONE } }\nend\n", after: "require 'sidekiq/web'\n"
    insert_into_file 'config/initializers/sidekiq.rb', "\nSidekiq.configure_client do |config|\n  config.redis = { ssl_params: { verify_mode: OpenSSL::SSL::VERIFY_NONE } }\nend\n", after: /end\n/
  end
end

apply_self!