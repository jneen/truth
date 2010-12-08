module Truth
  module Hookable
    def hooks
      @hooks ||= {}
    end

    def get_hooks(name)
      hooks[name.to_sym] ||= []
    end

    def hook(name, &blk)
      get_hooks(name) << blk
    end

    def emit(name, *args)
      get_hooks(name).map do |blk|
        blk.call(*args)
      end
    end

    def hook_wrap(name, *args, &blk)
      emit :"before_#{name}"
      r = yield
      emit :"after_#{name}"
      r
    end
  end
end
