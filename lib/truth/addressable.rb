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
      configuration.addressables.remove(self)
      configuration.addressables << self

      configuration.networks.each do |net|
        net.addressables.remove(self)
        if net.cidr.include? new
          net.addressables << self
        else
          net.addressables.remove(self)
        end
      end
    end

    def address_str
      address.to_s
    end

  end
end
