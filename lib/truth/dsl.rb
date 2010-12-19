require_local 'dsl/*_dsl.rb'

module Truth
  class Dsl
    def initialize(target)
      @target = target
    end

    def delegate(meth, name, &blk)
      @target.send(meth, name) do |obj|
        obj.dsl_eval(&blk)
      end
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
