
class Dinosaur
  attr_reader :name , :period , :continent , :diet , :weight , :walk , :desc
  def initialize(name,period,continent,diet,weight,walk,desc)
    @name = name
    @period = period
    @continent = continent
    @diet = diet
    @weight = weight
    @walk = walk
    @desc = desc
  end
  
  def to_s
    "#{name}, #{period}, #{continent}, #{diet}, #{weight}, #{walk}, #{desc}"
  end
end

