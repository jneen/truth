require 'rubygems'
require 'ffaker'
require 'spec/autorun'

require File.expand_path(
  File.join(
    File.dirname(__FILE__),
    '..',
    'lib',
    'truth'
  )
)

require_local('support','**','*.rb')

Spec::Runner.configure do |config|
  config.include Truth
  config.include Builders
end
