module IPLogic
  class IP
    def rrepr
      "IP[#{self.to_s.inspect}]"
    end
  end

  class CIDR
    def hash
      self.inspect.hash
    end

    include Comparable
    def <=>(other)
      self.ip <=> other.ip
    end

    def rrepr
      "CIDR[#{self.to_s.inspect}]"
    end
  end
end
