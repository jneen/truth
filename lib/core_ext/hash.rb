class Hash
  # Merge in the values of the given hash,
  # skipping those keys which are already present.
  # @param [Hash] the hash to merge in.
  def rmerge!(hsh)
    hsh.each do |k,v|
      self[k] = v unless self.has_key? k
    end
    self
  end

  # Non-destructive version of `rmerge!`
  def rmerge(hsh)
    self.dup.rmerge!(hsh)
  end

  def accept_options!(hsh)
    opts_diff = self.keys - hash.keys
    raise ArgumentError <<-msg.squish unless opts_diff.empty?
      Unrecognized options #{opts_diff.inspect}
    msg
    options.rmerge!(hsh)
  end

  def accept_options(hsh)
    self.dup.accept_options!(hsh)
  end

  # Destructively map the keys.
  # NB: Make sure the output of the mapping function
  # preserves uniquess!
  def map_keys!
    keys.each do |k|
      self[yield(k)] = self.delete(k)
    end
    self
  end

  # Non-destructive version of `map_keys!`
  def map_keys(&blk)
    self.dup.map_keys!(&blk)
  end

  # Destructively map the hash's values
  def map_values!
    self.each do |k,v|
      self[k] = yield v
    end
    self
  end

  def map_values(&blk)
    self.dup.map_values!(&blk)
  end

  # Destructively map both keys and values.
  # @yield the mapper
  # @yieldparam key
  # @yieldparam value
  # @yieldreturn [Array] containing +[new_key,new_value]+
  def map!
    self.keys.each do |k|
      new_k, new_v = yield(k, self.delete(k))
      self[new_k] = new_v
    end
    self
  end
end
