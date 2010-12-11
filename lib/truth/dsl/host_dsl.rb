module Truth
  class Dsl
    class HostDsl < Dsl
      def loc(l)
        
      end

      def interface(i)
        host.interfaces << i
      end
    end
  end
end
