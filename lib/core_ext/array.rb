class Array
  alias rand_int rand
  def rand
    self[rand_int(self.size)]
  end

  def shuffle!
    sort! { [-1,0,1].rand }
  end

  def shuffle
    dup.shuffle!
  end
end
