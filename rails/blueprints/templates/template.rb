def apply_self!
  @templates ||= Dir.glob("#{File.dirname(__FILE__)}/*/template.rb")
                    .select { |f| f.include?('blueprints') }

  puts "============================"
  puts "Choose a template by number:"
  @templates.each_with_index do |template, i|
    puts "(#{i}) #{template.split('templates/').last.split('/template.rb').first.titleize}"
  end
  puts "============================"

  template_option = ask("Template Number: ", :blue)
  apply @templates[template_option.to_i]
end

apply_self!
