class Dino
  
  attr_accessor :name, :period, :continent, :diet, :weight_in_lbs, :walking, :description
  
  def initialize(dino_hash)
    dino_hash.each { |k,v| send("#{k}=", v) }
  end  
  
  def is_fat?
    @weight_in_lbs != nil && @weight_in_lbs > 2000
  end
  
  def is_small?
    @weight_in_lbs != nil && @weight_in_lbs <=2000
  end
  
  def is_biped?
    @walking.to_s.downcase.eql? "biped"
  end
  
  def is_carnivore?
    %w(carnivore insectivore piscivore).include? @diet.downcase
  end
  
end
