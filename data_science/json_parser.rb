class JsonParser
  def self.parse(file_name)
    raise ArgumentError unless File.exists?(file_name)
  end
end