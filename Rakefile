require 'rake'
require './lib/truth'

begin
  require 'rspec/core'
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new('spec') do |s|
    s.pattern = 'spec/**/*_spec.rb'
    s.ruby_opts = ['-r ./spec/spec_helper.rb']
  end
#rescue LoadError => e
#  puts "Rspec not found."
#  #pass.  rspec is not required
end
