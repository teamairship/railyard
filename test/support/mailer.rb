class ActiveSupport::TestCase
  teardown { ActionMailer::Base.deliveries.clear }
end
