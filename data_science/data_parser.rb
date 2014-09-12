class DataParser
  attr_reader :filename

  def initialize(filename)
    raise ArgumentError, "Must initialize with a filename" unless filename
    @filename = filename
  end
end

