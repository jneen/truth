module Truth
  class Index
    include Hookable

    IndexError = Class.new(StandardError)

    def hashed
      @hashed ||= {}
    end
    alias to_h hashed

    def get(name, &constructor)
      hashed[name] || begin
        obj = constructor.call(name)
        add(obj) if block_given?
        obj
      end
    end
    alias [] get

    def list
      @list ||= []
    end
    enumerate_by :list

    def clear
      hashed.clear
      list.clear
    end

    def size
      list.size
    end

    def include?(el)
      # tests for both names and objects
      hashed.include?(el) || list.include?(el)
    end

    attr_reader :name_key, :sort_key
    def initialize(options={})
      @name_key = options[:name_key] || :name
      @sort_key = options[:sort_key] || @name_key
    end

    def add(obj)
      return self if self.include? name_of(obj)

      hook_wrap :add, obj do
        begin
          name = name_of(obj)
          insert_sorted(obj)
          hashed[name] = obj
          obj
        rescue Exception => e
          delete(name)
          raise e
        end
      end

      self
    end
    alias << add

    def delete(name)
      if name.respond_to? name_key
        name = name_of(name)
      end

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

    def import(index, &blk)
      index.each do |el|
        self << el if blk.nil? || blk.call(el)
      end
    end

    def track(index, &blk)
      index.always do |el|
        self << el if blk.nil? || blk.call(el)
      end
    end

    def always(&blk)
      each(&blk)
      hook(:add, &blk)
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
      raise IndexError, <<-msg.squish if include? obj
        Tried to insert #{obj.inspect} into #{self.inspect},
        which is a duplicate of #{self[name_of(obj)].inspect}.
      msg

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
