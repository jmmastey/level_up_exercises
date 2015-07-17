require_relative "dino_catalog.rb"

class DinoDex
	DINO_DATA_DIR = 'dino_data'

	def initialize
		catalog_all_dino_data
	end

	def search(filters = {})
		filters.each do |field, value|
			field_value_dino_addrs = @catalog.dinos_where(field, value)
			@filtered_dino_addrs ||= field_value_dino_addrs
			@filtered_dino_addrs = @filtered_dino_addrs & field_value_dino_addrs
		end
		@catalog.dinos_at @filtered_dino_addrs
	end

	def catalog_all_dino_data
		@catalog = DinoCatalog.new
		dino_data_dir_path = "#{DINO_DATA_DIR}/*.csv"
		Dir.glob(dino_data_dir_path).each { |csv| @catalog.catalog_csv csv }
	end

	def export_dinos_as_json
		@catalog.to_json
	end

	def print_dino_info(dino)
	end
end

dinoDex = DinoDex.new
puts dinoDex.search(continent: 'North America', diet: 'Carnivore')
puts '============================'
puts dinoDex.export_dinos_as_json