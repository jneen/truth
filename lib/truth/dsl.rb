require_local 'dsl/*_dsl.rb'

module Truth
  class Dsl
    def initialize(target)
      @target = target
    end
  end
end

def Truth(version=nil, &blk)
  return Truth unless version || block_given?

  version ||= Truth.create_version
  config = Truth::Configuration.version(version)

  if blk
    Truth::Dsl::ConfigurationDsl.new(config).instance_eval(&blk)
  end

  config
end
