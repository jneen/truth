require 'rubygems'
require 'iplogic'
require 'erubis'
include IPLogic

require File.join(
  File.dirname(__FILE__),
  'core_ext'
)

module Truth
  DIRS = {}
  DIRS[:lib] = File.expand_path(File.dirname(__FILE__))
  DIRS[:root] = File.expand_path(File.join(DIRS[:lib], '..'))
  DIRS[:vendor] = File.expand_path(File.join(DIRS[:root]), 'vendor')

  def self.clear
    Configuration.clear
  end
end

def Truth(version=nil, &blk)
  return Truth unless version || block_given?

  version ||= Truth.create_version
  config = Truth::Configuration.version(version)

  if blk
    config.dsl_eval(&blk)
  end

  config
end

# Truth core
require_local 'core_ext'
require_local 'truth/hookable'
require_local 'truth/index'
require_local 'truth/entity'
require_local 'truth/version'
require_local 'truth/configuration'

# Truth modules
require_local 'truth/addressable'
require_local 'truth/locatable'

# Truth builtin types
require_local 'truth/host'
require_local 'truth/interface'
require_local 'truth/network'
require_local 'truth/datacenter'
require_local 'truth/vip'
require_local 'truth/switch'
require_local 'truth/domain'
require_local 'truth/nameable'
