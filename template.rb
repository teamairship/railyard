require 'bundler'
require 'json'
require "fileutils"
require "shellwords"

def add_template_repository_to_source_path
  if __FILE__ =~ %r{\Ahttps?://}
    require "tmpdir"
    source_paths.unshift(tempdir = Dir.mktmpdir("railyard-"))
    at_exit { FileUtils.remove_entry(tempdir) }
    git clone: [
      "--quiet",
      "https://github.com/mdelkins/railyard.git",
      tempdir
    ].map(&:shellescape).join(" ")

    if (branch = __FILE__[%r{railyard/(.+)/template.rb}, 1])
      Dir.chdir(tempdir) { git checkout: branch }
    end
  else
    source_paths.unshift(File.dirname(__FILE__))
  end
end

def apply_self!
  add_template_repository_to_source_path

  copy_file 'Gemfile', force: true
  copy_file 'Guardfile'
  copy_file 'Procfile.dev'
  copy_file 'foreman', '.foreman'
  copy_file 'gitignore', '.gitignore', force: true
  copy_file 'overcommit.yml', '.overcommit.yml'
  copy_file 'rubocop.yml', '.rubocop.yml'

  if yes?('Do you use rvm?')
    template 'ruby-gemset.tt', '.ruby-gemset', force: true
  end

  apply 'circleci/template.rb'

  after_bundle do
    rails_command 'db:drop db:create'
    run 'bin/setup'
    rails_command 'active_storage:install'
    rails_command 'db:migrate'
  end
end

apply_self!
