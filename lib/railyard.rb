require "active_support"
require "active_support/core_ext"
require "dotenv"
require "logger"
require "open3"
require "terminal-table"
require "thor"
require "yaml"

env = ENV.fetch("RAILYARD_ENV") { "development" }
env = [".env", ".", env].join
Dotenv.load(env)

module Railyard
end

require_relative "railyard/cli"
