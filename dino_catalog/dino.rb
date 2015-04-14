class Dino
  attr_reader :period
  attr_reader :diet
  attr_reader :feet
  attr_reader :weight
  attr_reader :name

  def initialize(dino_data)
    # These are the instance variables for the Dino class
    #     @name = nil
    #     @period = nil
    #     @continent = nil
    #     @diet = nil
    #     @weight = nil
    #     @feet = nil
    #     @description = nil

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
end
