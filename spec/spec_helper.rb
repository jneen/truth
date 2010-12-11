puts "==== running spec_helper ===="
require 'rubygems'
require 'ffaker'
require 'rspec'

require File.expand_path(
  File.join(
    File.dirname(__FILE__),
    '..',
    'lib',
    'truth'
  )
)

require_local('support','**','*.rb')

RSpec.configure do |config|
  config.include Truth
  config.include Builders
end
