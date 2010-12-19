module Truth
  class Dsl
    class DatacenterDsl < Dsl
      def switch(name, &blk)
        delegate :switch, name.to_i, &blk
      end
    end
  end
end
