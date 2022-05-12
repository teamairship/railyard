# frozen_string_literal: true

# A sample Guardfile
# More info at https://github.com/guard/guard#readme

## Uncomment and set this to only include directories you want to watch
# directories %w(app lib config test spec features) \
#  .select{|d| Dir.exists?(d) ? d : UI.warning("Directory #{d} does not exist")}

## Note: if you are using the `directories` clause above and you are not
## watching the project directory ('.'), then you will want to move
## the Guardfile to a watched dir and symlink it back, e.g.
#
#  $ mkdir config
#  $ mv Guardfile config/
#  $ ln -s config/Guardfile .
#
# and, you'll have to watch "config/Guardfile" instead of "Guardfile"

guard :minitest, spring: 'bin/rails test', all_after_pass: false do
  watch(%r{^app/(.+)\.rb$}) { |m| ["test/#{m[1]}", "test/#{m[1]}_test.rb"] }
  watch(%r{^app/controllers/(admin|application)_controller\.rb$}) { 'test/controllers' }
  watch(%r{^app/controllers/(.+)_controller\.rb$}) { |m| "test/integration/#{m[1]}_test.rb" }
  watch(%r{^app/views/(.+)_mailer/.+}) { |m| "test/mailers/#{m[1]}_mailer_test.rb" }
  watch(%r{^app/domain/(.+)\.rb$}) { |m| "test/domain/#{m[1]}_test.rb" }
  watch(%r{^app/lib/(.+)\.rb$}) { |m| "test/app_lib/#{m[1]}_test.rb" }
  watch(%r{^lib/(.+)\.rb$}) { |m| "test/lib/#{m[1]}_test.rb" }
  watch(%r{^test/test_helper\.rb$}) { 'test' }
  watch(%r{^test/.+_test\.rb$})
  watch(%r{^app/views/(.*_mailer/)?([^/]+)\.erb$}) { ['test/mailers', 'test/integration'] }
end

guard :rubocop, cli: %w[-D -S] do
  watch(/.rubocop.yml/)
  watch(/.+\.rb$/)
  watch(/Rakefile/)
  watch(%r{(?:.+/)?\.rubocop\.yml$}) { |m| File.dirname(m[0]) }
end

guard 'brakeman', run_on_start: true, quiet: true do
  ## Lets not watch files for brakeman, just scan on guard start, and full runs.
  #
  # watch(%r{^app/.+\.(erb|haml|rhtml|rb)$})
  # watch(%r{^config/.+\.rb$})
  # watch(%r{^lib/.+\.rb$})
  # watch('Gemfile')
end

guard 'spring', bundler: true do
  watch('Gemfile.lock')
  watch(%r{^config/})
end
