module Truth
  class Entity
    module Associations

      module ClassMethods
        # a key is a simple property.
        def key(type, &blk)
          blk ||= lambda { |x| x }

          define_method(type) do
            blk.call(self[type.to_sym])
          end

          define_method :"#{type}=" do |arg|
            self[type.to_sym] = blk.call(arg)
          end
        end

        # defines a cached index, and a
        # simple get_or_create method with
        # the given name.
        def index(type, options={})
          type = to_key(type)

          plural = options[:plural] || "#{type}_index"

          define_method(plural) do
            indices[type]
          end

          define_method(type) do |name|
            target = self

            indices[type] ||= Index.new(options)

            indices[type].get(name) do |name|
              yield name, target if block_given?
            end
          end
        end

        def context(klass, options={}, &blk)
          assoc = options.delete(:as) || self.class.name.underscore
          assoc = assoc.to_sym

          klass.index(assoc, options) do |name, target|
            blk.call(inst, target)
            inst = new(self, name)
            inst
          end
        end
      private
        def to_key(obj)
          obj = obj.name if obj.respond_to? :name
          obj = obj.demodulize.underscore if obj.respond_to? :demodulize
          obj = obj.to_sym if obj.respond_to? :to_sym

        end
      end

      def indices
        @indices ||= {}
      end

    end
  end
end
