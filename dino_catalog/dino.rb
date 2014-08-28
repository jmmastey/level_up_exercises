require 'active_model'

class Dino
  include ActiveModel::Validations

  validates_presence_of :name, :period, :walking

  attr_accessor :name, :period, :continent, :diet,
    :weight, :walking, :description

  NAME_ALIASES = ["name", "genus"]
  PERIOD_ALIASES = ["period"]
  CONTINENT_ALIASES = ["continent"]
  DIET_ALIASES = ["diet"]
  SPECIAL_DIET_CARNIVORE_ALIASES = ["carnivore"]
  WEIGHT_ALIASES = ["weight", "weight_in_lbs"]
  WALKING_ALIASES = ["walking"]
  DESCRIPTION_ALIASES = ["description"]

  def initialize(args)

    args.each do |k,v|
      instance_variable_set("@#{k}", v) unless v.nil?
    end

  end

  def to_string
    "#{name} (#{period}, #{continent}, #{diet}, #{weight},
    #{walking}, #{description})"
  end

  def to_json_hash
    {'name' => @name, 'period' => @period, 'continent' => @continent,
      'weight' => @weight, 'description' => @description}
  end


  def self.get_symbol_key(key)

    if NAME_ALIASES.include?(key)
      return :name
    elsif PERIOD_ALIASES.include?(key)
      return :period
    elsif CONTINENT_ALIASES.include?(key)
      return :continent
    elsif DIET_ALIASES.include?(key)
      return :diet
    elsif WEIGHT_ALIASES.include?(key)
      return :weight
    elsif WALKING_ALIASES.include?(key)
      return :walking
    elsif DESCRIPTION_ALIASES.include?(key)
      return :description
    elsif SPECIAL_DIET_CARNIVORE_ALIASES.include?(key)
      return :special_diet_carnivore
    else
      # maybe we have a special case?
      puts "Unkown Dino Attribute Key"
      return nil
    end

  end


end
