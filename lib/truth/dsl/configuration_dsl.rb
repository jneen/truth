module Truth
  class Dsl
    class ConfigurationDsl < Dsl
      def host(name, &blk)
        name = name.to_sym
        @target.host(name) do |host|
          Dsl::HostDsl.new(host).instance_eval(&blk)
        end
      end

      def network(*args, &blk)
        cidr = CIDR(*args)
        network = @target.network(cidr.to_s) do |network|
          Dsl::NetworkDsl.new(network).instance_eval(&blk)
        end
      end

      def vip(name, &blk)
        @target.vip(name.to_sym) do |vip|
          Dsl::VIPDsl.new(vip).instance_eval(&blk)
        end
      end

      def datacenter(name, &blk)
        @target.datacenter(name.to_sym) do |dc|
          Dsl::DatacenterDsl.new(dc).instance_eval(&blk)
        end
      end
    end
  end
end
