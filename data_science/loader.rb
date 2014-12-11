class Loader
  attr_reader :file_contents
  def initialize(filepath)
    @filepath = filepath
    @file_contents = File.read(@filepath)
  end
end
