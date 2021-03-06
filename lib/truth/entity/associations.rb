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

          define_method type do |name, &block_for_index|
            index_get(type, name, &block_for_index)
          end
        end

        def includes(type, &blk)
          define_method :on_create do
            send(type).import(configuration.send(type)) do |obj|
              !blk || blk.call(self, obj)
            end
          end
        end

        # specify that an entity is to be defined in the context
        # of another class.  Most common is the top-level, which is
        #
        #     class Network
        #       context Configuration
        #       # ...
        #     end
        #
        # It sets up an index on the specified class with the given options.
        def context(klass, options={}, &blk)
          assoc = options.delete(:as) || self.name.demodulize.underscore
          assoc = assoc.to_sym

          nk = options[:name_key] ||= get_name_key

          self.hook_instance("change_#{nk}") do |inst, old, new|
            inst.context.indices[assoc].update_membership(inst)
          end

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

      # will yield an interface of the given type and name
      # before it's added to the index.  This is necessary
      # to let the dsl set up the object before all the
      # index hooks kick in.
      def index_get(type, name, &blk)
        index = send("#{type}_index")

        # we *could* let the index handle get-or-set,
        # but we need to yield the object before the
        # index gets it.
        if index.has_key? name
          yield(index[name]) if block_given?
          index[name]
        else
          initializer = self.class.type_initializers[type]
          inst = initializer.call(name, self) if initializer

          #HACK: this goes somewhere else
          inst.dsl_eval { template :default }

          yield(inst) if block_given?
          index << inst
          inst
        end
      end

    end
  end
end
