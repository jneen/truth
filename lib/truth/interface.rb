module Truth
  class Interface < Entity
    include Addressable

    context Host, :plural => :interfaces

    key :mac

    class InterfaceDsl < Dsl
      def mac(mac)
        @target[:mac] = mac.downcase
      end

      def address(addr)
        @target[:address] = IP[addr]
      end
    end
  end
end
