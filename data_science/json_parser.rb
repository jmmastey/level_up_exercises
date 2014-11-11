require "json"

class JSONParser
  attr_reader :filename

  def initialize(filename)
    @filename = filename
  end

  def fetch_data
    JSON.parse(File.read(filename))
  end
end
