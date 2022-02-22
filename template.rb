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
  @existing_repository ||= (File.exist?('.git') || :nope)
  @existing_repository == true
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

  if yes?('Will this application be multi-tenant?')
    run 'bundle add acts_as_tenant --skip-install'
    run 'bundle add pretender --skip-install'
  end

  if yes?('Will this application accept payments?')
    run 'bundle add pay --skip-install'
    run 'bundle add stripe --skip-install'
  end

  after_bundle do
    rails_command 'db:drop db:create'
    run 'bin/setup'
    rails_command 'active_storage:install'
    rails_command 'db:migrate'
    generate 'pundit:install'

    run 'cp config/environments/production.rb config/environments/staging.rb'
    run 'rubocop -A'
    run 'overcommit --install'

    git :init unless existing_repository?
    git checkout: '-b main' unless existing_commits?
  end
end

apply_self!
