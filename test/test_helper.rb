require_relative './support/rails'

Dir[Rails.root.join('test/support/**/*.rb')].sort.each { |f| require f }
