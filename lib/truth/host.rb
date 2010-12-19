module Truth
  class Host < Entity
    context Configuration, :plural => :hosts
    include Locatable

    class HostDsl < Dsl
      def interface(i, &blk)
        delegate :interface, i.to_sym, &blk
      end
    end
  end
end
