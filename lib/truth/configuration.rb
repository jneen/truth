module Truth
  class Configuration < Entity
    class << self
      cache :versions do
        Index.new(:name_key => :version)
      end

      def clear
        versions.clear
      end

      def version(ver)
        versions.get(ver.to_i) do
          new(ver.to_i)
        end
      end
    end

    attr_reader :version
    def initialize(version)
      @version = version
    end

    # end the tree-climbing here.
    def configuration
      self
    end

    def inspect
      "#<#{self.class.name} [ #{self.version} ]>"
    end

    # -*- dsl methods -*-
    class ConfigurationDsl < Dsl
      def context_line
        "Truth(#{@target.version})"
      end

      def host(loc, &blk)
        delegate(:host, loc, &blk)
      end

      def network(*args, &blk)
        cidr = CIDR[*args]
        delegate :network, cidr.to_s, &blk
      end

      def vip(name, &blk)
        delegate :vip, name.to_sym, &blk
      end

      def datacenter(name, &blk)
        delegate :datacenter, name.to_sym, &blk
      end

      def template_blocks
        @templates ||= {}
      end
    end
  end
end
