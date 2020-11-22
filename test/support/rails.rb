ENV["RAILS_ENV"] ||= 'test'
require_relative '../../config/environment'
require 'rails/test_help'

class ActiveSupport::TestCase
  include ActionDispatch::TestProcess

  fixtures :all
end
