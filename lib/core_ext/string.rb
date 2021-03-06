class String
  def indent(spaces=2)
    return self.undent(-spaces) if spaces < 0

    lines = self.split $/
    lines.each do |line|
      if line.blank?
        line.clear
      else
        line.insert(0, ' '*spaces)
      end
    end
    lines.join $/
  end

  def blank?
    !!match(/^\s+$/)
  end

  def undent(spaces=2)
    return self.indent(-spaces) if spaces < 0

    lines = self.split $/
    lines.each do |line|
      line.slice!(0...spaces)
    end
    lines.join $/
  end

  def demodulize!
    gsub! /^.*::/, ''
  end

  def demodulize
    dup.demodulize!
  end

  def underscore!
    gsub! /::/, '/'
    gsub! /([A-Z]+)([A-Z][a-z])/, '\1_\2'
    gsub! /([a-z\d])([A-Z])/, '\1_\2'
    tr!   '-', '_'
    downcase!
    self
  end

  def underscore
    dup.underscore!
  end

  def camelize!
    downcase!
    gsub! /\//, '::'
    gsub! /((^|_)\w)/ do |letter|
      letter[-1..-1].upcase
    end

    self
  end

  def camelize
    dup.camelize!
  end

  def lchomp!(ch=$/)
    if self.starts_with? ch
      slice!(0...(ch.length))
    end
    self
  end

  def lchomp(ch=$/)
    self.dup.lchomp!(ch)
  end

  def unchomp!(ch=$/)
    self.chomp!(ch)
    self << ch
    self
  end

  def unchomp(ch=$/)
    self.dup.unchomp!(ch)
  end

  def unlchomp!(ch=$/)
    self.lchomp!(ch)
    self.insert(0,ch)
    self
  end

  def unlchomp(ch=$/)
    self.dup.unlchomp!(ch)
  end

  def squish!
    strip!
    gsub! /\s+/, ' '
    self
  end

  def squish
    dup.squish!
  end
end
