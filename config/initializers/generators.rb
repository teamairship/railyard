require 'rails/generators/migration'
require 'rails/generators/actions/create_migration'
require 'rails/generators/named_base'

Rails.application.config.generators do |g|
  # Disable generators we don't need.
  g.javascripts false
  g.stylesheets false
end

module AddFrozenStringLiteralComment
  def add_frozen_string_literal_comment(dist)
    return unless File.exist?(dist) && File.extname(dist) == '.rb'

    File.open(dist, 'r') do |f|
      body = f.read

      File.open(dist, 'w') do |new_f|
        new_f.write("# frozen_string_literal: true\n\n" + body)
      end
    end
  end
end

module GeneratorPrepend
  include AddFrozenStringLiteralComment

  def invoke!
    res = super
    add_frozen_string_literal_comment(existing_migration)
    res
  end
end

module TemplatePrepend
  include AddFrozenStringLiteralComment

  def template(source, *args, &block)
    res = super
    add_frozen_string_literal_comment(args.first)
    res
  end
end

Rails::Generators::Actions::CreateMigration.prepend GeneratorPrepend
Rails::Generators::NamedBase.prepend TemplatePrepend
