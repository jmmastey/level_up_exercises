class JsonMaker
	def self.export_json(dino_collection)
		dino_collection.map do |dinosaur|
			JsonMaker.to_json(dinosaur)
		end
	end

	private
	
	def self.to_json(dinosaur)
		dino_json = {}
		dinosaur.instance_variables.each do |variable|
			dino_json[variable] = dinosaur.instance_variable_get(variable)	
		end
		dino_json
	end
end
