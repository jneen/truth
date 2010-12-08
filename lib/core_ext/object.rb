class Object
  def ivar(name)
    instance_variable_get(name) || begin
      instance_variable_set(name, yield) if block_given?
    end
  end
end
