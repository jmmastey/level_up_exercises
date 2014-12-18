module CSVtoHashTools
  
  require 'csv'
  
  CSV::Converters[:blank_to_nil] = lambda do |field|
    field && field.empty? ? nil : field
  end

  def CSV_to_hash(file)
    @csv = CSV.read(file, :headers => true, :header_converters => :symbol, :converters => :all)
    @csv = @csv.map { |row| row.to_hash }
  end

  def normalize_african_hash(dino_hash_array)
    dino_hash_array.each do |dino|
      dino[:name] = dino.delete :genus
      dino[:weight_in_lbs] = dino.delete :weight
      dino[:diet] = dino.delete :carnivore
      dino[:continent] = "Africa"
      if dino[:diet].eql? "Yes"
        dino[:diet] = "Carnivore"
      else
        dino[:diet] = "Herbivore"
      end
    end
  end
end
