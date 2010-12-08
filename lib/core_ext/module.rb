class Module
  def cache(name, &blk)
    define_method(name) do
      ivar :"@#{name}", &blk
    end
  end

  def enumerate_by(method)
    include Enumerable
    %w(
      each
      to_a
      include?
      first
      last
    ).each do |enum_method|
      module_eval <<-ruby, __FILE__, __LINE__
        def #{enum_method}(*args, &blk)
          self.#{method}.#{enum_method}(*args, &blk)
        end unless instance_methods.include? :#{enum_method}
      ruby
    end
  end
end
