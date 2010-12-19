class File
  class << self
    # Write to the given filename
    # @param [String] path to the file
    # @param [String] content to be written
    def write(fname, content)
      File.open(fname, 'w') do |f|
        f.puts content
      end
    end
  end
end
