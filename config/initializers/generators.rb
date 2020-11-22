require 'rails/generators'

Rails.application.config.generators do |g|
  g.javascripts false
  g.stylesheets false
end

return unless defined?(::Rails::Generators)

module RailsGeneratorFrozenStringLiteralPrepend
  RUBY_EXTENSIONS = %w[.rb .rake]

  def render
    RUBY_EXTENSIONS.include?(File.extname(self.destination)) &&
      "# frozen_string_literal: true\n\n" + super ||
      super
  end
end

Thor::Actions::CreateFile.prepend RailsGeneratorFrozenStringLiteralPrepend
