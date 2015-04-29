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
    @continent ||= 'Africa'

    @diet = 'Carnivore' if @diet == 'Yes'
    @diet = 'Herbivore' if @diet == 'No'

    @weight = @weight.to_i if @weight
  end

  def carnivore?
    ["Carnivore", "Insectivore", "Piscivore"].include?(@diet)
  end

  def small_dino?(weight_cutoff)
    @weight && @weight < weight_cutoff
  end

  def big_dino?(weight_cutoff)
    @weight && @weight > weight_cutoff
  end

  def dino_in_era?(era_of_interest)
    # ignore case of the text in era with /i in regular expression
    #!@era[/#{era_of_interest}/i].nil?
    @era.downcase.include?(era_of_interest.downcase)
  end

  def biped?
    @walking_style[/Biped/] == "Biped"
  end

  def summarize_dino
    dino_values = instance_variables.map do |dino_attribute|
      dino_info = instance_variable_get("#{dino_attribute}")
      if dino_info
        attribute = dino_attribute.to_s.slice(1..dino_attribute.length)
        "#{attribute} : #{formatted_string(attribute, dino_info)} \n"
      end
    end
    dino_values.select { |dino_string| dino_string }
  end

  private

  def formatted_string(attribute, value)
    return "#{value}  lbs" if attribute == "weight"
    value
  end
end
