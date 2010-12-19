module Truth
  class Dsl
    class HostDsl < Dsl
      def interface(i, &blk)
        delegate :interface, i.to_sym, &blk
      end
    end
  end
end
