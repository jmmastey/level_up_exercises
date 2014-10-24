class Dino

  attr_reader :name, :period, :continent, :diet, :weight, :walking, :description

  def initialize (name, period, continent, diet, weight, walking, description)
    @name=name
    @period=period
    @continent=continent
    @continent="Africa" if continent.to_s.length==0 #if empty string set to 'Africa'
    @diet=diet
    @weight=weight
    @walking=walking
    @description=description
  end #end of initialize

  def to_s
    "#{@name} #{@period} #{@continent} #{@diet} #{@weight} #{@walking} #{@description}"
  end

end

