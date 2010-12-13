module Truth
  class Dsl
    class DatacenterDsl < Dsl
      def switch(name, &blk)
        @target.switch(name.to_i) do |switch|
          Dsl::SwitchDsl.new(switch).instance_eval(&blk)
        end
      end
    end
  end
end
