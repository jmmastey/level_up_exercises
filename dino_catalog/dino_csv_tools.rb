
module DinoCSVTools
  
  require 'csv'
  
  CSV::Converters[:blank_to_nil] = lambda do |field|
    field && field.empty? ? nil : field
  end

  def CSV_to_hash_array(file)
    
    @csv = CSV.read(file, :headers => true, :header_converters => :symbol, :converters => :all)
    @csv = @csv.map { |row| row.to_hash }
    
  end

  def normalize_african_dinos(dinos)
    
    dinos.each do |dino|
      dino[:name] = dino.delete :genus
      dino[:weight_in_lbs] = dino.delete :weight
      dino[:diet] = dino.delete :carnivore
      dino[:continent] = "Africa"
      dino[:diet] = "Carnivore" if dino[:diet].eql? "Yes"
      dino[:diet] = "Herbivore" if dino[:diet].eql? "No"
    end
  end
  
  def merge_dinos(joes_dinos, piratebay_dinos)
    joes_dinos.concat(piratebay_dinos)
  end
end
