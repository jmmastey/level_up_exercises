require('json')
class JSONParser
  def init
  end

  def parse(filepath)
    begin
      file = File.read(filepath)
      JSON.parse(file)
    rescue
      {}
    end
  end
end

parser = JSONParser.new
json = parser.parse('test_data.json')
puts json[0]['date']