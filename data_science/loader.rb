require 'json'

class Loader  
  def initialize(filepath)
    @filepath = filepath
  end

  def parse
    file_contents = File.read(@filepath)
    JSON.parse(file_contents)
  end
end
