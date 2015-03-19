class DinoCatalog
  WEIGHT_IN_TONS = 4000
  def initialize(dino_data)
    @dino_catalog = dino_data
  end

  def get_walking(type)
   @dino_catalog.select{ |k, v| type.include?(v.walk) if v.walk }
  end

  def get_diet(type)
    @dino_catalog.select { |k, v| type.include?(v.diet) if v.diet }
  end

  def get_specific_dinosaur(param)
    @dino_catalog.select { |k, v| param.include?(v.name) if v.name }
  end
 
  def get_big_dinosaurs
    @dino_catalog.select { |k, v| v.weight > WEIGHT_IN_TONS}
  end

  def get_small_dinosaurs
    @dino_catalog.select { |k, v| v.weight <= WEIGHT_IN_TONS unless v.weight.zero?}
  end
  
  def get_period_specific_dinosaurs(param)
    @dino_catalog.select { |k, v| v.period.split(" ").any?{|item| param.include? item} }
  end
  
  def get_dinosaur_collection
     @dino_catalog 
  end

  def print_data 
    @dino_catalog.each do |k, v|
      v.display
      puts "\n"
    end
  end
  
  def print_filtered_catalog
    if @dino_catalog.empty?
      puts "No records found matching your criteria"
    else
      print_data
    end
  end  
end
