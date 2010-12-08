module Truth
  class Entity
    module Erb

      # -*- Class Methods -*-
      module ClassMethods
        def erb(type)
          type = type.to_sym

          erbs[type] ||= begin
            template = File.read(File.join(
              Truth::DIRS[:lib],
              'truth',
              'templates',
              self.name.demodulize.underscore,
              "#{type}.#{subtypes[type]}.erb"
            ))

            Erubis::Eruby.new(template)
          end
        end
      private
        def subtypes
          {
            :dsl => 'rb',
          }
        end

        def erbs
          @erbs ||= {}
        end
      end # module ClassMethods

      # -*- Instance Methods -*-
      def render(type)
        erb(type).result(binding)
      end

    private
      def erb(type)
        self.class.erb(type)
      end

      # -*- helpers -*-
      def r(obj)
        obj.rrepr
      end

      def i(obj)
        obj.indent.lstrip.chomp
      end

    end # module Erb
  end # class Entity
end
