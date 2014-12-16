require 'csv'

CSV::Converters[:blank_to_nil] = lambda do |field|
  field && field.empty? ? nil : field
end

$dinos = CSV.read("dinodex.csv", :headers => true, :header_converters => :symbol, :converters => :all)
#p $dinos[0]
$dinos = $dinos.map {|row| row.to_hash}

$african_dinos = CSV.read("african_dinosaur_export.csv", :headers => true, :header_converters => :symbol, :converters => :all)
$african_dinos = $african_dinos.map {|row| row.to_hash}

#p $dinos[0]
#puts dinos[0]

class Dino
  attr_accessor :name, :period, :continent, :diet, :weight_in_lbs, :walking, :description
  
  def initialize(hash)
    hash.each {|k,v| send("#{k}=", v) }
  end  
  
  def is_fat?
      weight_in_lbs > 2000 && weight_in_lbs != nil
  end
  
  def is_biped?
    walking.downcase == "biped"
  end

end

class DinoDex
  attr_accessor :dinosaurs
  
  def initialize
    @dinosaurs = []
    $dinos.each {|dino| @dinosaurs << dino}
#    $african_dinos.each {|african_dino| @dinosaurs <<}
  end
end

albert = Dino.new($dinos[0])
#albert.weight_in_lbs = 2430
puts albert.is_fat?
puts albert.weight_in_lbs
puts albert.is_biped?
puts albert.description

dino_dex = DinoDex.new
puts dino_dex.dinosaurs
