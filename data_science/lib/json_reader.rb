require 'json'

module JsonReader
  private

  def read(file)
    raise("File #{file} not found") unless File.exist?(file)
    json = File.read(file)
    JSON.parse(json)
  end
end
