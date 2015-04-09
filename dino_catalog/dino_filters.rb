#This file contains functions that can be used to filter the dinosaurs to find ones 
#with specific attributes.

class Dino_filters

   attr_reader :dino_objects

   @dino_objects = nil

   def initialize(input_list)
      @dino_objects = input_list
   end

 
   def find_bipeds()
      filtered_list = @dino_objects.select{ |dino| dino.dino_feet[/Biped/] == "Biped"}
      filtered_list = Dino_filters.new(filtered_list)
      return filtered_list
   end


   def find_carnivores()
      filtered_list = @dino_objects.select{ |dino| dino.dino_diet == true}
      filtered_list = Dino_filters.new(filtered_list)
      return filtered_list
   end

   def find_dinos_specific_period(period)
      filtered_list = @dino_objects.select{ |dino| dino.dino_period[/#{period}/i] != nil}   #ignore case of the text in period
      filtered_list = Dino_filters.new(filtered_list)
      return filtered_list
   end

   def find_big_dinos(size)
      #size should be an integer that is the cutoff for the weight
      filtered_list = @dino_objects.select{ |dino| dino.dino_weight > size if dino.dino_weight != nil }
      filtered_list = Dino_filters.new(filtered_list)
      return filtered_list
   end

   def find_small_dinos(size)
      #size should be an integer that is the cutoff for the weight
      filtered_list = @dino_objects.select{ |dino| dino.dino_weight < size if dino.dino_weight != nil}
      filtered_list = Dino_filters.new(filtered_list)
      return filtered_list
   end

   def print_list()
      for dino in @dino_objects
         dino.print_dino
      end
   end

end  #class
