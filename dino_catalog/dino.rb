class Dino
  attr_accessor :name, :period, :continent, :diet, :weight, :walking, :description
  GIANT_WEIGHT = 4000

  def initialize(params)
    params.each do |key, value|
      self.send("#{key}=", value)
    end 
  end

  def biped?
    @walking.downcase.eql?("biped")
  end
  
  def carnivore?
    ["carnivore", "insectivore", "piscivore"].include? @diet.downcase
  end

  def from?(periods)
    periods.any? { |period| @period.downcase.include? period.downcase }
  end

  def giant?
    @weight.to_i > GIANT_WEIGHT
  end

  def to_s
    instance_variables.map { |characteristic| sanitize_and_print(characteristic) }.compact.join("\n")
  end

  private
  def sanitize_and_print(characteristic)
    (instance_variable_get characteristic).nil? ? nil : "#{sanitize(characteristic)}: #{instance_variable_get characteristic}"
  end

  def sanitize(instance_variable)
    instance_variable[1..instance_variable.size].to_s.capitalize
  end

end
