class Array
  # Move over Object#rand
  alias rand_int rand

  # Pick a random element of the array
  # @return [Object] a random element
  def rand
    self[rand_int(self.size)]
  end

  # Destructively shuffle the elements
  # @return [Array] self
  def shuffle!
    sort! { [-1,0,1].rand }
  end

  # Non-destructively shuffle the elements
  # @return [Array] self.dup
  def shuffle
    dup.shuffle!
  end
end
