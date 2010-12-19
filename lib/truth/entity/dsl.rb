require_local 'dsl/*_dsl.rb'

module Truth
  class Entity
    class Dsl
      def initialize(target)
        @target = target
      end

      def delegate(meth, name, &blk)
        @target.send(meth, name) do |obj|
          obj.dsl_eval(&blk)
        end
      end
    end
  end
end
