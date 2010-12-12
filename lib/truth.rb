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
end

# Truth core
require_local 'core_ext'
require_local 'truth/hookable'
require_local 'truth/index'
require_local 'truth/entity'
require_local 'truth/version'
require_local 'truth/configuration'
require_local 'truth/dsl'

# Truth modules
require_local 'truth/addressable'

# Truth builtin types
require_local 'truth/host'
require_local 'truth/interface'
require_local 'truth/network'
require_local 'truth/datacenter'
