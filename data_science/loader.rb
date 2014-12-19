require 'json'

class Loader  
  def initialize(filepath)
    @filepath = filepath
  end

  def parse
    JSON.parse(File.read(@filepath))
  end
end
