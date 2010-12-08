require_local 'dsl/host_dsl'

module Truth
  class Dsl
    def initialize(target)
      @target = target
    end

    def host(name, &blk)
      name = name.to_sym
      host = Host.open(name)
      Dsl::HostDsl.new(host).instance_eval(&blk)
    end
  end
end

def Truth(version=nil, &blk)
  return Truth unless block_given?

  version ||= Truth.create_version
  config = Configuration.version(version)
  Truth::Dsl.new(config).instance_eval(&blk)
end
