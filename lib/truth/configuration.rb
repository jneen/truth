module Truth
  class Configuration < Entity
    class << self
      cache :versions do
        Index.new(:name_key => :version)
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
  end
end
