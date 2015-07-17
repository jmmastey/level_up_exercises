require 'csv'
require 'json'

class DinoCatalog

	def initialize
		@dinos = []
		@dino_field_index = {}
	end

	def catalog_csv(csv_file)
		dino_data =  CSV.read(csv_file, { encoding: "UTF-8", headers: true, 
						                            header_converters: :symbol, converters: :all})
    dino_data.map { |dino| catalog_dino dino.to_hash }
	end

  def catalog_dino(dino)
    dino_addr = @dinos.size
    @dinos << dino
    dino.each { |field, value| index_dino_field(dino_addr, field, value) }
  end

  def index_dino_field(dino_addr, field, value)
    @dino_field_index[field] ||= {}
    @dino_field_index[field][value] ||= []
    @dino_field_index[field][value] << dino_addr
  end

  def dinos_at(addrs)
    @dinos.values_at *addrs
  end

  def dinos_where(field, value)
    @dino_field_index[field][value]
  end

  def to_json
    @dinos.to_json
  end
end