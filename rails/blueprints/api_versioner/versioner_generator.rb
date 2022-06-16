# frozen_string_literal: true

class VersionerGenerator < Rails::Generators::Base
  source_root File.expand_path('../../..', __dir__)

  def copy_directory
    versions = Dir.glob('app/controllers/api/*')
                  .grep(/v\d+/)
                  .map { |dir| /v(\d+)/.match(dir)[1]&.to_i }
    current_version = versions.max
    if current_version.nil?
      empty_directory "app/controllers/api/v1"
        
      # Routes
      insert_into_file 'config/routes.rb', before: /^end/ do  
        "\n\s\sconcern :api_version do\n\s\s\s\s# i.e. resources :users\n\s\send\n\s\snamespace :api, defaults: { format: :json } do\n\s\s\s\snamespace :v1 do\n\s\s\s\s\s\sconcerns :api_version\n\s\s\s\send\n\s\send\n"
      end
  
      # Tests
      if Dir.exists?('spec')
        empty_directory "spec/controllers/api/v1"
      else
        empty_directory "test/controllers/api/v1"
      end
      say("v1 generated! Generate new API versions by running `rails generate versioner` in the console", :green)
    else
      next_version = current_version + 1
      deprecating_versions = versions.filter { |version| next_version - version > 2 }

      # API
      directory "app/controllers/api/v#{current_version}", "app/controllers/api/v#{next_version}"
      Dir.glob("app/controllers/api/v#{next_version}/**/*.rb") do |file|
        gsub_file file, /V#{current_version}/, "V#{next_version}"
      end

      # Tests
      if Dir.exist?('spec/controllers/api')
        directory "spec/controllers/api/v#{current_version}", "test/controllers/api/v#{next_version}"
        Dir.glob("spec/controllers/api/v#{next_version}/**/*.rb") do |file|
          gsub_file file, /V#{current_version}/, "V#{next_version}"
        end
      else
        directory "test/controllers/api/v#{current_version}", "test/controllers/api/v#{next_version}"
        Dir.glob("test/controllers/api/v#{next_version}/**/*.rb") do |file|
          gsub_file file, /V#{current_version}/, "V#{next_version}"
        end
      end

      # Routes
      insert_into_file 'config/routes.rb', after: 'namespace :api, defaults: { format: :json } do' do
        "\n\s\s\s\snamespace :v#{next_version} do\n\s\s\s\s\s\sconcerns :api_version\n\s\s\s\send"
      end
      say("API v#{next_version} generated!", :green)
      
      return unless deprecating_versions.any?

      deprecate = yes?("Do you want to deprecate API #{deprecating_versions.map { |v| "v#{v}" }.join(', ')}?")
      return unless deprecate

      deprecating_versions.each do |version|
        remove_dir "app/controllers/api/v#{version}"
        remove_dir "test/controllers/api/v#{version}" if Dir.exist?('test/controllers/api')
        remove_dir "spec/controllers/api/v#{version}" if Dir.exist?('spec/controllers/api')
        gsub_file(
          'config/routes.rb',
          "\s\s\s\snamespace :v#{version} do\n\s\s\s\s\s\sconcerns :api_version\n\s\s\s\send",
          ''
        )
      end
      say("API v#{next_version} generated!", :green)
    end
  end
end
