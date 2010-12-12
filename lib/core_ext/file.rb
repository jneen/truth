class File
  class << self
    def write(fname, content)
      File.open(fname, 'w') do |f|
        f.puts content
      end
    end
  end
end
