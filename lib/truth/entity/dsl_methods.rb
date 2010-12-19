module Truth
  class Entity
    module DslMethods
      # -*- class methods -*-
      module ClassMethods
        def dsl_class
          class_name = :"#{self.name.demodulize}Dsl"
          if const_defined? class_name
            const_get class_name
          else
            const_set class_name, Class.new(Dsl)
          end
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
