require_local 'entity/associations'
require_local 'entity/erb'
require_local 'entity/dsl'
require_local 'entity/dsl_methods'

module Truth
  class Entity
    # -*- Class Methods -*-
    include Entity::Associations
    extend Entity::Associations::ClassMethods

    include Entity::Erb
    extend Entity::Erb::ClassMethods

    include Entity::DslMethods
    extend Entity::DslMethods::ClassMethods

    include Hookable

    class << self
      def inherited(klass)
        klass.class_eval do
          key :name
        end
      end

      def get_name_key
        @name_key || :name
      end

    private
      def name_key(key)
        @name_key = key.to_sym
        key @name_key
      end
    end

    # -*- Instance Methods -*-

    attr_reader :context, :name
    def initialize(context, name)
      @context = context
      self[self.class.get_name_key] = name

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

    def keys
      @keys ||= {}
    end

    def [](key)
      keys[key.to_sym]
    end

    def []=(key, val)
      key = key.to_sym
      return val if self[key] == val

      hook_wrap :"change_#{key}", self[key], val do
        keys[key] = val
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
