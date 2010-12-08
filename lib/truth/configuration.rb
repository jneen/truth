module Truth
  class Configuration < Entity
    class << self
      cache :versions do
        Index.new(:name_key => :version)
      end

      def version(ver)
        versions.get(ver.to_i) do
          new(:version => ver.to_i)
        end
      end

      def objects(klass)
        @objects ||= {}
        @objects[klass.name] ||= Index.new
      end
    end

    attr_reader :version
    def initialize(version)
      @version = version
    end

    index :host, :plural => :hosts do |name|
      Host.new(self, name.to_sym)
    end

    # end the tree-climbing here.
    def configuration
      self
    end
  end
end
