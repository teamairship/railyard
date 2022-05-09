class ActiveSupport::TestCase
  teardown { Faker::UniqueGenerator.clear }
end
