module Truth
  class Dsl
    class HostDsl < Dsl
      def loc(l)
        l = l.to_s
        l =~ /^u(\d+)r(\d+)\.(\w+)$/
        @target[:rack_unit] = $1.to_i
        @target[:rack] = $2.to_i
        @target[:datacenter] = $3

        @target[:loc] = l

        l
      end

      def interface(i, &blk)
        @target.interface i.to_sym do |int|
          InterfaceDsl.new(int).instance_eval(&blk)
        end
      end
    end
  end
end
