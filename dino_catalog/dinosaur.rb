
class Dino
  
  WEIGHT_LIMIT = 4000
  
  attr_accessor :name, :period, :continent, :diet, :weight_in_lbs, :walking, :description
  
  def initialize(dino_hash)
    dino_hash.each { |k,v| send("#{k}=", v) }
  end  
  
  def fat?
    @weight_in_lbs && @weight_in_lbs > WEIGHT_LIMIT
  end
  
  def small?
    @weight_in_lbs && @weight_in_lbs <= WEIGHT_LIMIT
  end
  
  def biped?
    @walking.to_s.downcase.eql? "biped"
  end
  
  def quadruped?
    @walking.to_s.downcase.eql? "quadruped"
  end
  
  def carnivore?
    %w( carnivore insectivore piscivore ).include? @diet.downcase
  end
  
  def herbivore?
    @diet.downcase == "herbivore"
  end
  
  def to_s
    puts "Name:\n #{name}"
    puts "Period:\n #{period}"
    puts "Continent:\n #{continent}"
    puts "Diet:\n #{diet}" if @diet
    puts "Weight (lbs):\n #{weight_in_lbs}" if @weight_in_lbs
    puts "Walking:\n #{walking}" if @walking
    puts "Description:\n #{description}" if @description
  end
  
end
