
class Dinosaur
  attr_reader :name , :period , :continent , :diet , :weight , :walk , :desc
  def initialize(name,period=nil,continent=nil,diet=nil,weight=nil,walk=nil,desc=nil)
    if name.is_a? Hash
      @name = name['name'] || name['genus']
      @period = name['period']
      @continent = name['continent'] || "Africa"
      @diet = name['diet'] || parse_diet(name['carnivore'])
      @walk = name['walking']
      @desc = name['description'] || ""
      begin
        @weight = Integer(name['weight_in_lbs'] || name['weight'])
      rescue
        @weight = -1
      end
    else 
      @name = name
      @period = period
      @continent = continent
      @diet = diet
      @weight = weight
      @walk = walk
     @desc = desc
    end
  end

  def parse_diet(carnivore)
    (name['Carnivore'] == 'Yes') ? 'Carnivore' : 'Herbivore'
  end
  
  def to_s
    if @weight == -1
      "#{name}, #{period}, #{continent}, #{diet}, , #{walk}, #{desc}"
    else 
      "#{name}, #{period}, #{continent}, #{diet}, #{weight}, #{walk}, #{desc}"
    end
  end
end

