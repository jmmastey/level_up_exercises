
class Dinosaur
  attr_reader :name
  attr_reader :period
  attr_reader :continent
  attr_reader :diet
  attr_reader :weight
  attr_reader :walk
  attr_reader :desc
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
    return "#{name}, #{period}, #{diet}, #{weight}"
  end
end

