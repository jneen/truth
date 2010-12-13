module Truth
  Configuration.cache(:addressables) do
    Index.new(:name_key => :address_str)
  end

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

    # TODO: is there a way to make this cleaner?
    def on_change_address(old, new)
      configuration.addressables.update_membership(self)

      configuration.networks.each do |net|
        net.addressables.update_membership(self) do
          net.cidr.include? new
        end
      end
    end

    def address_str
      address.to_s
    end

  end
end
