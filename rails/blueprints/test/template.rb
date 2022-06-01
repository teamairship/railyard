require 'colorize'

def apply_self!
  @templates ||= Dir.glob("#{File.dirname(__FILE__)}/*/sub_template.rb")
                    .select { |f| f.include?('blueprints') }

  puts "============================".blue
  puts "Which testing framework do you want to use:".blue
  @templates.each_with_index do |template, i|
    puts "(#{i}) #{template.split('/test/').last.split('/sub_template.rb').first.titleize}".blue
  end
  puts "============================".blue

  template_option = ask("Test Option: ", :blue)
  apply @templates[template_option.to_i]
end

apply_self!