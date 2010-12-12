module Truth
  module Addressable
    class << self
      def included(klass)
        klass.class_eval do
          key :address
        end

        klass.dsl_class.class_eval do
          def address(addr)
            @target.address = IP(addr)
          end
        end
      end
    end

    def on_change_address(old, new)
      configuration.networks.each do |net|
        if net.cidr.include? new
          net.addressables << self
        else
          net.addressables.delete(self)
        end
      end
    end

    def address_str
      address.to_s
    end

  end
end
