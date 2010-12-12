require_local 'entity/associations'
require_local 'entity/erb'

module Truth
  class Entity
    # -*- Class Methods -*-
    include Entity::Associations
    extend Entity::Associations::ClassMethods

    include Entity::Erb
    extend Entity::Erb::ClassMethods

    class << self
      include Enumerable

      def open(name)
        all[name.to_sym] ||= new(name)
      end
    end

    # -*- Instance Methods -*-

    attr_reader :context, :name
    def initialize(context, name, keys={})
      @context = context
      @name = name
      @keys = keys.map_keys!(&:to_sym)
    end

    def indices
      @indices ||= {}
    end

    # climbs up the tree until the configuration returns itself
    def configuration
      self.context.configuration
    end

    def [](key)
      @keys[key.to_sym]
    end

    def []=(key, val)
      @keys[key.to_sym] = val
    end

    def to_dsl
      render :dsl
    end
  end
end
