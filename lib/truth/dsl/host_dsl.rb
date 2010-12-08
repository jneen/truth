module Truth
  class Dsl
    class HostDsl < Dsl
      def initialize(host)
        @host = host
      end

      def loc(l)
        
      end

      def interface(i)
        host.interfaces << i
      end
    end
  end
end
