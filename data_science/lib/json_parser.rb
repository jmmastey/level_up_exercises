require 'json'

class JsonParser

	def initialize(json)
		file = File.read(json)
		data_hash = JSON.prase(file)

	end

end

JsonParser.new('../source_data.json')