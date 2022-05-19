require 'bundler'
require 'json'
require 'fileutils'
require 'shellwords'

def add_template_repository_to_source_path
  if __FILE__ =~ %r{\Ahttps?://}
    require "tmpdir"
    source_paths.unshift(tempdir = Dir.mktmpdir("railyard-"))
    at_exit { FileUtils.remove_entry(tempdir) }
    git clone: [
      "--quiet",
      "https://github.com/teamairship/railyard.git",
      tempdir
    ].map(&:shellescape).join(" ")

    if (branch = __FILE__[%r{railyard/(.+)/template.rb}, 1])
      Dir.chdir(tempdir) { git checkout: branch }
    end
  else
    source_paths.unshift(File.dirname(__FILE__))
  end
end

def existing_commits?
  system("git log > /dev/null 2>&1")
end

def existing_repository?
  @existing_repository ||= (File.exist?(".git") || :nope)
  @existing_repository == true
end

def blueprints
  @blueprints ||= Dir.glob("#{File.dirname(__FILE__)}/blueprints/**/template.rb")
                     .select { |f| f.include?('blueprints') && !f.include?('templates') }
end

def apply_self!
  add_template_repository_to_source_path

  gem "bugsnag"
  gem 'rubocop-rails', require: false

  gem_group :development, :test do
    gem "bundle-audit"
    gem "dotenv-rails"
    gem "faker"
    gem "guard"
    gem "guard-minitest"
    gem "guard-brakeman"
    gem "guard-rubocop"
    gem "guard-shell"
    gem "guard-spring"
    gem "standard"
    gem "simplecov"
  end

  gem_group :development do
    gem "foreman"
    gem "overcommit"
  end

  gem_group :test do
    gem "database_cleaner"
    gem "minitest-retry"
    gem "mocha"
  end

  copy_file "env.example"
  copy_file "Guardfile"
  copy_file "gitignore", '.gitignore', force: true
  copy_file "overcommit.yml", ".overcommit.yml"
  copy_file "foreman", ".foreman"
  copy_file "rubocop.yml", ".rubocop.yml"

  apply "circleci/template.rb"
  apply "config/template.rb"
  apply "test/template.rb"

  if yes?("Do you use rvm?", :blue)
    template "ruby-version.tt", ".ruby-version", force: true
    template "ruby-gemset.tt", ".ruby-gemset", force: true
    run "rvm use"
  end

  after_bundle do
    rails_command "db:drop db:create"
    run "bin/setup"
    rails_command "active_storage:install"
    rails_command "db:migrate"

    run "cp config/environments/production.rb config/environments/staging.rb"
    run "bundle exec standardrb --fix", abort_on_failure: false
    run "overcommit --install"

    if yes?("Do you want to use a template?", :blue)
      apply "#{File.dirname(__FILE__)}/blueprints/templates/template.rb"
    else
      blueprints.each do |blueprint|
        puts "Applying Blueprint: #{blueprint}..."
        apply blueprint
      end
    end

    rails_command "db:migrate"
    generate "controller home index"

    git :init unless existing_repository?
    git checkout: "-b main" unless existing_commits?

    puts "============================================"
    puts "App successfully created, thanks for using Railyard :)"
    puts "Running Rubocop now"
    puts "============================================"

    run "rubocop -A"
  end
end

apply_self!
