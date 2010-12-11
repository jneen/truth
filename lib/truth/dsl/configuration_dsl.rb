module Truth
  class Dsl
    class ConfigurationDsl < Dsl
      def host(name, &blk)
        name = name.to_sym
        host = @target.host(name)
        Dsl::HostDsl.new(host).instance_eval(&blk)
        host
      end

      def network(*args, &blk)
        cidr = CIDR(*args)
        network = @target.network(cidr)
        Dsl::NetworkDsl.new(network).instance_eval(&blk)
        network
      end
    end
  end
end
