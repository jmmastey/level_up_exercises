class JsonParser

  def self.parse(filename)
    json_rows = []
    file_read = open("source_data.json").read
    json_rows = JSON.parse(file_read)
    json_rows
  end
end
