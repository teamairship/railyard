# frozen_string_literal: true

require 'bundler'
require 'json'
require 'fileutils'
require 'shellwords'

def add_template_repository_to_source_path
  if __FILE__ =~ %r{\Ahttps?://}
    require 'tmpdir'
    source_paths.unshift(tempdir = Dir.mktmpdir('railyard-'))
    at_exit { FileUtils.remove_entry(tempdir) }
    git clone: [
      '--quiet',
      'https://github.com/teamairship/railyard.git',
      tempdir
    ].map(&:shellescape).join(' ')

    if (branch = __FILE__[%r{railyard/(.+)/template.rb}, 1])
      Dir.chdir(tempdir) { git checkout: branch }
    end
  else
    source_paths.unshift(File.dirname(__FILE__))
  end
end

def existing_commits?
  system('git log > /dev/null 2>&1')
end

def existing_repository?
  @existing_repository ||= (File.exist?(".git") || :nope)
  @existing_repository == true
end

def docker?
  @docker ||= yes?('Do you want to use Docker?')
end

def apply_self!
  add_template_repository_to_source_path

  copy_file 'env.example'
  copy_file 'Gemfile', force: true
  copy_file 'package.json', force: true
  copy_file '.eslintrc.js'
  copy_file 'Guardfile'
  copy_file 'Procfile.dev'
  copy_file 'foreman', '.foreman'
  copy_file 'gitignore', '.gitignore', force: true
  copy_file 'overcommit.yml', '.overcommit.yml'
  copy_file 'rubocop.yml', '.rubocop.yml'

  apply 'circleci/template.rb'
  apply 'config/template.rb'
  apply 'test/template.rb'

  template 'ruby-gemset.tt', '.ruby-gemset', force: true if yes?('Do you use rvm?')

  if docker?
    apply 'bin/template.rb'
    template 'docker-compose.yml.tt', 'docker-compose.yml'
    template 'Dockerfile.tt', 'Dockerfile.dev'
    copy_file 'config/cable.yml', force: true
  end

  after_bundle do
    rails_command 'db:drop db:create' unless docker?
    run 'bin/setup' unless docker?
    rails_command 'active_storage:install'
    rails_command 'db:migrate' unless docker?
    generate 'pundit:install'

    run 'cp config/webpack/production.js config/webpack/staging.js'
    run 'cp config/environments/production.rb config/environments/staging.rb'
    run 'rubocop -A'
    run 'overcommit --install'

    git :init unless existing_repository?
    git checkout: '-b main' unless existing_commits?
  end
end

apply_self!
