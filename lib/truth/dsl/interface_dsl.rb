module Truth
  class Dsl
    class InterfaceDsl < Dsl
      def mac(mac)
        @target[:mac] = mac.downcase
      end

      def address(addr)
        @target[:address] = IP(addr)
      end
    end
  end
end
