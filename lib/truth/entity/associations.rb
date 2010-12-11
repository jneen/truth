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

        def type_initializers
          @type_initializers ||= {}
        end

        # defines a cached index, and a
        # simple get_or_create method with
        # the given name.
        def index(type, options={}, &blk)
          type = to_key(type)

          define_method("#{type}_index") do
            indices[type] ||= Index.new(options)
          end

          if options[:plural]
            alias_method options[:plural], :"#{type}_index"
          end

          type_initializers[type] = blk

          module_eval <<-ruby, __FILE__, __LINE__
            def #{type}(name, &blk)
              index_get(#{type.rrepr}, name, &blk)
            end
          ruby
        end

        def context(klass, options={}, &blk)
          assoc = options.delete(:as) || self.name.demodulize.underscore
          assoc = assoc.to_sym
          klass.index(assoc, options) do |name, target|
            inst = new(target, name)
            yield(inst, target) if block_given?
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

      # -*- Instance Methods -*-
    private
      def indices
        @indices ||= {}
      end

      def index_get(type, name, &blk)
        send("#{type}_index").get(name) do |n|
          initializer = self.class.type_initializers[type]
          inst = initializer.call(n, self) if initializer
          yield(inst) if block_given?
          inst
        end
      end

    end
  end
end
