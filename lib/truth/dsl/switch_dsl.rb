module Truth
  class Dsl
    class SwitchDsl < Dsl
      def rack_unit(ru)
        dc = @target.datacenter = @target.context.name
        ru = @target.rack_unit = ru.to_i
        @target.loc = "u#{ru}r#{@target.rack}.#{dc}"
      end
    end
  end
end
