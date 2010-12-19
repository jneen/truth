module Truth
  class Entity
    module Dsl
      # -*- class methods -*-
      module ClassMethods
        def dsl_class
          dsl = "#{self.name.demodulize}Dsl"
          Truth::Dsl.const_get(dsl)
        end
      end


      def dsl_context
        @dsl_context ||= self.class.dsl_class.new(self)
      end

      def dsl_eval(&blk)
        dsl_context.instance_eval(&blk)
      end
    end
  end
end
