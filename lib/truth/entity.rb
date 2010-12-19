require_local 'entity/associations'
require_local 'entity/erb'
require_local 'entity/dsl'

module Truth
  class Entity
    # -*- Class Methods -*-
    include Entity::Associations
    extend Entity::Associations::ClassMethods

    include Entity::Erb
    extend Entity::Erb::ClassMethods

    include Entity::Dsl
    extend Entity::Dsl::ClassMethods

    include Hookable

    # -*- Instance Methods -*-

    attr_reader :context, :name
    def initialize(context, name, keys={})
      @context = context
      @name = name
      @keys = keys.map_keys!(&:to_sym)
      emit :create
    end

    def indices
      @indices ||= {}
    end

    def inspect
      "<#{self.class.name} [ #{name.inspect} #{@keys && @keys.inspect} ]>"
    end

    # climbs up the tree until the configuration returns itself
    def configuration
      self.context.configuration
    end

    def [](key)
      @keys[key.to_sym]
    end

    def []=(key, val)
      key = key.to_sym
      return self if self[key] == val

      hook_wrap :"change_#{key}", self[key], val do
        @keys[key] = val
      end
    end

    def to_dsl
      render :dsl
    end

    def render_to_file(type, fname)
      File.write(fname, render(type))
    end
  end
end
