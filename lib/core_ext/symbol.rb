class Symbol
  def to_proc
    proc do |*args|
      args.shift.send(self, *args)
    end
  end

  include Comparable
  def <=>(other)
    self.to_s <=> other.to_s
  end
end
