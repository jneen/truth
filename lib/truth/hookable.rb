module Truth
  module Hookable
    def get_hooks(name)
      hooks[:"#{name}"] ||= []
    end

    def hook(name, &blk)
      get_hooks(name) << blk
    end
    alias on hook

    def emit(name, *args)
      # first ask the object itself
      send(:"on_#{name}", *args) if respond_to? :"on_#{name}"

      # then look for external hooks
      get_hooks(name).each do |blk|
        blk.call(*args)
      end
    end

    def hook_wrap(name, *args, &blk)
      emit "before_#{name}", *args
      r = yield
      emit "#{name}", *args
      emit "after_#{name}", *args
      r
    end

  private
    def hooks
      @hooks ||= {}
    end

  end
end
