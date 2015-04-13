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

    # Loop over the dino_data.  Each defined instance variable in Dino is a key
    # in the dictionary.  Set dino_value equal to its instance variable.
    dino_data.each do |dino_var, dino_value|
      instance_variable_set("@#{dino_var}", dino_value)
    end

    # Some instance fields need special treatment
    @continent = 'Africa' unless @continent

    # Set @diet to false if all carnivorous diets are false
    @diet = (@diet == 'Yes' || @diet == 'Carnivore' || \
                                         diet == 'Insectivore')
    # Convert weight into an integer
    @weight = @weight.to_i unless @weight.nil?

  end

  def print_dino
    # This function prints out all of the data that was collected about this
    # particular dino
    dino_variables = %w(name continent period diet weight feet description)

    # Build up the string of dino info using a loop
    dino_string = "**************************************************\n"
    for var in dino_variables
      dino_info = instance_variable_get("@#{var}")
      if dino_info != nil
        dino_string << var + ": " + dino_string_helper(var, dino_info) + "\n"
      end
    end
    puts dino_string
  end

  def dino_string_helper(var_name_string, value)
    # This function helps make the dino info string pretty when it is printed.
    if var_name_string == "diet"
      return dino_diet_helper(value)
    elsif var_name_string == "weight"
      return value.to_s + " lbs"
    else
      return value
    end
  end

  def dino_diet_helper(value)
    if value
      return "Carnivore"
    else
      return "Not Carnivore"
    end
  end
end
