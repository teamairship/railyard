# frozen_string_literal: true

# lib = File.expand_path('../lib', __FILE__)
# $LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require_relative 'lib/railyard/version'
require 'sprockets/railtie'

Gem::Specification.new do |spec|
  spec.name          = 'Railyard'
  spec.version       = Railyard::VERSION
  spec.authors       = ['Jorge Andrade']
  spec.email         = ['j.andrade@svitla.com']

  spec.summary       = 'Add new gems to you rails add with no effort'
  spec.description   = 'Railyard will help you to add gems to your rails app with just a command line,
                        forget about configurations, Captaian will fo everything for you.'
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.3.0')

  spec.add_dependency 'activesupport'
  spec.add_dependency 'dotenv'
  spec.add_dependency 'httparty', '~> 0.14'
  spec.add_dependency 'rails', '~> 7.0.2', '>= 7.0.2.3'
  spec.add_dependency 'terminal-table'
  spec.add_dependency 'thor', '~> 1.0'

  spec.add_development_dependency 'standardrb'
  spec.add_development_dependency 'bundler', '~> 2.1'
  spec.add_development_dependency 'rspec', '~> 3.0'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'bin'
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']
end
