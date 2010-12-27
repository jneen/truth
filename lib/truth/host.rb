module Truth
  class Host < Entity
    include Locatable

    name_key :loc

    context Configuration, :plural => :hosts

    key :name
    key :domain

    class HostDsl < Dsl
      def name(name)
        @target.name = name.to_sym
      end

      def interface(i, &blk)
        delegate :interface, i.to_sym, &blk
      end
    end
  end
end
