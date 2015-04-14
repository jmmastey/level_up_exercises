class Dino
  attr_reader :name
  attr_reader :period
  attr_reader :continent
  attr_reader :diet
  attr_reader :walking_style
  attr_reader :weight
  attr_reader :description

  def initialize(dino_data)

    # Each instance variable in Dino is a key in the dino_data dictionary.
    dino_data.each do |dino_var, dino_value|
      instance_variable_set("@#{dino_var}", dino_value)
    end

    # Some instance fields need special treatment
    @continent = 'Africa' unless @continent

    @diet = 'Carnivore' if @diet == 'Yes'
    @diet = 'Not carnivore' if @diet == 'No'

    @weight = @weight.to_i unless @weight.nil?
  end

  def print_dino
    # Print out all of the data associated with particular dino
    dino_values = self.instance_variables.map do |var|
      dino_info = instance_variable_get("#{var}")
      if dino_info != nil
        var_string = var.to_s.slice(1..-1)
        "#{var_string} : #{format_string(var_string, dino_info)} \n"
      end
    end
    dino_values = dino_values.select { |dino_string| not dino_string.nil? }
    puts dino_values
  end

  def format_string(var_name_string, value)
    return "#{value}  lbs" if var_name_string == "weight"
    return value
  end

  def carnivore?
    ["Carnivore", "Insectivore", "Piscivore"].include?(self.diet)
  end

  def small_dino?(weight_cutoff)
    self.weight < weight_cutoff unless self.weight.nil?
  end

  def big_dino?(weight_cutoff)
    self.weight > weight_cutoff unless self.weight.nil?
  end

  def dino_in_period?(period)
    # ignore case of the text in period with /i in regular expression
    !self.period[/#{period}/i].nil?
  end

  def biped?
    self.walking_style[/Biped/] == "Biped"
  end
end
