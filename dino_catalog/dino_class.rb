class Dinos

   attr_reader :dino_period
   attr_reader :dino_diet
   attr_reader :dino_feet
   attr_reader :dino_weight
   attr_reader :dino_name

   def initialize(dino_data)

      # These are the instance variables for the Dinos class
      @dino_name = nil
      @dino_period = nil
      @dino_continent = nil
      @dino_diet = nil
      @dino_weight = nil
      @dino_feet = nil
      @dino_description = nil

      # Different csv files have different headers (dictionary keys).  We want 
      # to translate from the dictionary key into the proper variable.  We 
      # translate using the translation dictionary, which maps headers to 
      # instance variables. 
      translate = {}
      translate[ 'Genus' ] = 'dino_name'
      translate[ 'Period' ] = 'dino_period'
      translate[ 'Carnivore' ] = 'dino_diet' 
      translate[ 'Weight' ] = 'dino_weight'
      translate[ 'Walking' ] = 'dino_feet'
      translate[ 'NAME' ]= 'dino_name'
      translate[ 'PERIOD' ] = 'dino_period'
      translate[ 'CONTINENT' ] = 'dino_continent'
      translate[ 'DIET' ] = 'dino_diet'
      translate[ 'WEIGHT_IN_LBS' ] = 'dino_weight'
      translate[ 'WALKING' ] = 'dino_feet'
      translate[ 'DESCRIPTION' ] = 'dino_description'

      # Loop over the dino_data.  Map dino_data key to its corresponding 
      # variable name.  Set the corresponding 
      # variable equal to the value associated with the dino_data key.
      dino_data.each do |dino_key, dino_value|
         # Look up dino_key in the translate dictionary. dino_var is currently a string. 
         dino_var = translate[dino_key]
         # Convert dino_var to a variable (from its string name) and assign data to it.
         instance_variable_set("@#{dino_var}", dino_value)
      end

      # Some instance fields need special treatment
      @dino_continent = 'Africa' if not @dino_continent 
  
      # Set @dino_diet to false if all carnivorous diets are false
      @dino_diet = (@dino_diet == 'Yes' || @dino_diet == 'Carnivore' ||  \
                                           @dino_diet == 'Insectivore') 
     
      # Convert weight into an integer
      @dino_weight = @dino_weight.to_i if @dino_weight != nil
         
   end  


   def print_dino()
      # This function prints out all of the data that was collected about this 
      # particular dino
  
      # Dino variables
      dino_variables = ["dino_name", "dino_continent", "dino_period", \
                  "dino_diet", "dino_weight", "dino_feet", "dino_description"]

      # Build up the string of dino info using a loop
      dino_string = "**************************************************\n"
      for var in dino_variables
         dino_info = instance_variable_get("@#{var}")
         dino_string << var + ": " + dino_string_helper(var, dino_info) + "\n"\
                                                              if dino_info
      end
      puts dino_string
     
   end


   def dino_string_helper(var_name_string, value)
      # This function helps make the dino info string pretty when it is printed.
      if var_name_string == "dino_diet"
         if value
            return "Carnivore"
         else
            return "Not Carnivore"
         end
      elsif var_name_string == "dino_weight"
         return value.to_s + " lbs"
      else
         return value
      end
   end
      

end
