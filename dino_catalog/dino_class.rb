class Dinos
  attr_reader :period
  attr_reader :diet
  attr_reader :feet
  attr_reader :weight
  attr_reader :name

  def initialize(dino_data)
    # These are the instance variables for the Dinos class
    #     @name = nil
    #     @period = nil
    #     @continent = nil
    #     @diet = nil
    #     @weight = nil
    #     @feet = nil
    #     @description = nil

    # Different csv files have different headers (dictionary keys).  We want
    # to translate from the dictionary key into the proper variable.  We
    # translate using the translation dictionary, which maps headers to
    # instance variables.
    translate = {}
    translate[:genus] = :name
    translate[:period] = :period
    translate[:carnivore] = :diet
    translate[:weight] = :weight
    translate[:walking] = :feet
    translate[:name] = :name
    translate[:continent] = :continent
    translate[:diet] = :diet
    translate[:weight_in_lbs] = :weight
    translate[:description] = :description

    # Loop over the dino_data.  Map dino_data key to its corresponding
    # variable name.  Set the corresponding
    # variable equal to the value associated with the dino_data key.
    dino_data.each do |dino_key, dino_value|
      # Look up dino_key in the translate dictionary. dino_var is currently a
      # string.
      dino_var = translate[dino_key]
      # Convert dino_var to a variable (from its string name) and assign data to
      # it.
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
      if dino_info
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
