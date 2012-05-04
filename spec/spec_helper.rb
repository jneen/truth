require 'rubygems'
require 'bundler'
Bundler.require

require 'truth'

require_local('support','**','*.rb')

RSpec.configure do |config|
  config.include Truth
  config.include Builders
end
