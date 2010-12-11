module Truth
  class Index
    include Hookable

    def hashed
      @hashed ||= {}
    end
    alias to_h hashed

    def get(name)
      hashed[name] || begin
        add(yield(name)) if block_given?
      end
    end
    alias [] get

    def list
      @list ||= []
    end
    enumerate_by :list

    def size
      list.size
    end

    attr_reader :name_key, :sort_key
    def initialize(options={})
      @name_key = options[:name_key] || :name
      @sort_key = options[:sort_key] || @name_key
    end

    def add(obj)
      hook_wrap :add, obj do
        name = name_of(obj)
        hashed[name] = obj
        insert_sorted(obj)
        obj
      end
    end
    alias << add

    def delete(name)
      if name.respond_to? name_key
        name = name_of(name)
      end
      name = name.to_sym

      hook_wrap :delete, name do
        obj = hashed.delete(name)
        list.reject! { |el| name_of(el) == name }
      end
    end

    def inspect
      list_inspect = list.map do |el|
        name_of(el)
      end.map(&:inspect).join(', ')

      "#<#{self.class.name} [ #{list_inspect} ]>"
    end

  private
    def name_of(obj)
      obj.send(name_key)
    end

    def sort_key_of(obj)
      obj.send(sort_key)
    end

    # TODO: binary search, but let's not preoptimize
    def insert_sorted(obj)
      name = sort_key_of(obj)
      inserted = false
      list.each_with_index do |e, i|
        if sort_key_of(e) > name
          list.insert i, obj
          inserted = true
          break
        end
      end

      list << obj unless inserted

      list
    end
  end
end
