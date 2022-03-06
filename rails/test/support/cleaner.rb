DatabaseCleaner.strategy = :truncation

class ActiveSupport::TestCase
  teardown { DatabaseCleaner.clean }
end
