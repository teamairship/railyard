# frozen_string_literal: true

module Railyard
  class Cli < Thor
    include Thor::Actions

    def initialize(*)
      super
      @logger = set_logger
    end

    desc "create APP", "creates a new rails app"
    def create(app)
      run "rails new #{app} -d postgresql -j esbuild -c tailwind -m ./rails/template.rb"
    rescue error
      p error
    end

    private

    attr_reader :logger

    def set_logger
      Logger.new(STDOUT).tap do |logger|
        logger.level = Logger::DEBUG
      end
    end
  end
end
