class Dino
  attr_reader :name
  attr_reader :era
  attr_reader :continent
  attr_reader :diet
  attr_reader :walking_style
  attr_reader :weight
  attr_reader :description

  def initialize(dino_data)
    # Each instance variable in Dino is a key in the dino_data dictionary.
    dino_data.each do |attribute, value|
      instance_variable_set("@#{attribute}", value)
    end

    # Some instance fields need special treatment
    @continent = 'Africa' unless @continent

    @diet = 'Carnivore' if @diet == 'Yes'
    @diet = 'Not carnivore' if @diet == 'No'

    @weight = @weight.to_i unless @weight.nil?
  end

  def print_dino
    dino_values = instance_variables.map do |var|
      dino_info = instance_variable_get("#{var}")
      if dino_info
        attribute = var.to_s.slice(1..-1)
        "#{attribute} : #{format_string(attribute, dino_info)} \n"
      end
    end
    dino_values = dino_values.select { |dino_string| !dino_string.nil? }
    puts dino_values
  end

  def format_string(attribute, value)
    return "#{value}  lbs" if attribute == "weight"
    return value
  end

  def carnivore?
    ["Carnivore", "Insectivore", "Piscivore"].include?(@diet)
  end

  def small_dino?(weight_cutoff)
    @weight < weight_cutoff if @weight
  end

  def big_dino?(weight_cutoff)
    @weight > weight_cutoff if @weight
  end

  def dino_in_era?(era_of_interest)
    # ignore case of the text in era with /i in regular expression
    !@era[/#{era_of_interest}/i].nil?
  end

  def biped?
    @walking_style[/Biped/] == "Biped"
  end
end
