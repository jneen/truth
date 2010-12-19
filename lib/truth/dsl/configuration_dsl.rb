module Truth
  class Dsl
    class ConfigurationDsl < Dsl
      def host(name, &blk)
        name = name.to_sym
        delegate(:host, name.to_sym, &blk)
      end

      def network(*args, &blk)
        cidr = CIDR(*args)
        delegate :network, cidr.to_s, &blk
      end

      def vip(name, &blk)
        delegate :vip, name.to_sym, &blk
      end

      def datacenter(name, &blk)
        delegate :datacenter, name.to_sym, &blk
      end
    end
  end
end
