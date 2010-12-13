module Truth
  Configuration.cache(:locatables) do
    Index.new(:name_key => :loc)
  end

  module Locatable
    class << self
      def included(klass)
        klass.class_eval do
          key :loc

          key :rack_unit
          key :rack
          key :datacenter
        end

        klass.dsl_class.class_eval do
          def loc(l)
            l = l.to_s
            l =~ /^u(\d+)r(\d+)\.(\w+)$/
            @target[:rack_unit] = $1.to_i
            @target[:rack] = $2.to_i
            @target[:datacenter] = $3.to_sym

            @target[:loc] = l

            l
          end
        end
      end
    end
  end
end
