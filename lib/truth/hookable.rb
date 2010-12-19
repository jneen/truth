module Truth
  # Hookable provides an object with a
  # simple hooking api.
  # @example
  #   class Foo
  #     include Truth::Hookable
  #     def on_test(arg1, arg2, arg3)
  #       puts "on_test here.  testing #{arg1}, #{arg2}, #{arg3}"
  #     end
  #   end
  #
  #   foo = Foo.new
  #   foo.hook :test do |arg1, arg2, arg3|
  #     puts "block here.  testing from #{arg1}, #{arg2}, #{arg3}"
  #   end
  #
  #   foo.emit :test, 1, 2, 3
  #   # on_test here.  testing 1, 2, 3
  #   # block here. testing 1, 2, 3
  #
  #   foo.emit :test, 'a', 'b', 'c'
  #   # on_test here.  testing a, b, c
  #   # block here.  testing a, b, c
  module Hookable
    def get_hooks(name)
      hooks[:"#{name}"] ||= []
    end

    # Register a hook on this object.
    # @param [#to_s] name the name of the event
    # @yield the receiver of the hook event
    def hook(name, &blk)
      get_hooks(name) << blk
    end
    alias on hook

    # Trigger all the hooks on a given event.
    # @param [#to_s] name the name of the event
    # @param *args the arguments to be yielded to the event handlers.
    def emit(name, *args)
      # first ask the object itself
      send(:"on_#{name}", *args) if respond_to? :"on_#{name}"

      # then look for external hooks
      get_hooks(name).each do |blk|
        blk.call(*args)
      end
    end

    # simple shortcut for wrapping code with before and after
    # events.
    # @example
    #   class Foo
    #     include Truth::Hookable
    #     def test
    #       hook_wrap :test, 1, 2, 3 do
    #         puts "running Foo#test"
    #       end
    #     end
    #   end
    #
    #   foo = Foo.new
    #   foo.hook(:before_test) { |a, b, c| puts "(before_test) testing #{a}, #{b}, #{c}" }
    #   foo.hook(:test) { |a, b, c| puts "(test) testing #{a}, #{b}, #{c}" }
    #   foo.hook(:after_test) { |a, b, c| puts "(after_test) testing #{a}, #{b}, #{c}" }
    #   foo.test
    #   # (before_test) testing 1, 2, 3
    #   # running Foo#test
    #   # (test) testing 1, 2, 3
    #   # (after_test) testing 1, 2, 3
    #
    #   @yield the code to make hookable.
    def hook_wrap(name, *args)
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
