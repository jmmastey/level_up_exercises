require 'json'

class JsonParser
	attr_accessor :data_hash

	def initialize(json)
		file = File.read(json)
		@data_hash = JSON.parse(file)
		puts data_hash.length

	end

	def talk
		puts "test"
	end

end

#puts Dir.pwd

#JsonParser.new("source_data.json")