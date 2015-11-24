class Dinosaur
  attr_reader :name, :period, :continent, :diet,
    :weight_in_lbs, :walking, :description

  BIG_WEIGHT_THRESHOLD = 4000

  def initialize(dinosaur)
    @name           = dinosaur.fetch(:name)
    @period         = dinosaur[:period]
    @continent      = dinosaur[:continent]
    @diet           = dinosaur[:diet]
    @weight_in_lbs  = dinosaur[:weight_in_lbs]
    @walking        = dinosaur[:walking]
    @description    = dinosaur[:description]
  end

  def biped?
    @walking == "Biped"
  end

  def carnivore?
    ["Carnivore", "Piscivore", "Insectivore"].include?(@diet)
  end

  def dino_in_period?(period)
    period.include?(@period)
  end

  def to_hash
    info = {
      name: @name,
      period: @period,
      continent: @continent,
      diet: @diet,
      weight_in_lbs: @weight_in_lbs,
      walking: @walking,
      description: @description,
    }
    info.delete_if { |k, v| v.nil? }
  end

  def big?
    @weight_in_lbs && @weight_in_lbs > BIG_WEIGHT_THRESHOLD
  end

  def small?
    @weight_in_lbs && @weight_in_lbs <= BIG_WEIGHT_THRESHOLD
  end

  def to_s
    dino_string = ""
    instance_variables.each do |var_name|
      attributor = instance_variable_get("#{var_name}")
      clean_var_name = var_name.to_s.tr("@", "")
      dino_string << "#{clean_var_name}: #{attributor} \n" if attributor
    end
    dino_string
  end
end
