require "json"

class FileTypeException < Exception
end

class JSONParser
  attr_reader :filename

  def initialize(filename)
    if filename.end_with? ".json"
      @filename = filename
    else
      raise FileTypeException, 'Not a JSON, buddy'
    end
  end

  def fetch_data
    JSON.parse(File.read(@filename))
  end
end
