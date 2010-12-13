module Truth
  class Dsl
    class HostDsl < Dsl
      def interface(i, &blk)
        @target.interface i.to_sym do |int|
          InterfaceDsl.new(int).instance_eval(&blk)
        end
      end
    end
  end
end
