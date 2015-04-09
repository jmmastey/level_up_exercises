require 'csv'
load 'dino_class.rb'
load 'dino_filters.rb'

def main()

   #Make an list of dino_class objects
   dino_objects = []

   #Loop over the csv files.  Create dino object and append them to a list of dino objects
   CSV.foreach('dino_csv_list') do |new_file|
      filename = new_file[0]
      dino_data = CSV.read(filename, :headers => true)
      dino_data.each do |row| 
         new_dino = Dinos.new(row.to_hash)
         dino_objects.push(new_dino)
      end
   end

   #Create Dino_filters object so that all the filter methods can be used
   dino_filter_object = Dino_filters.new(dino_objects)
 

   #Find bipeds
   puts '\n **********These are the bipeds!*******************'
   dino_filter_object.find_bipeds.print_list
  
   #Find carnivores
   puts '\n **********These are the carnivores!*******************'
   dino_filter_object.find_carnivores.print_list

   #Find dinos from Cretaceous periods
   puts '\n **********These are the Cretaceous dinos!*******************'
   dino_filter_object.find_dinos_specific_period('Cretaceous').print_list

   #Find big dinos
   puts '\n **********These are the dinos over 2 tons!*******************'
   dino_filter_object.find_big_dinos(4000).print_list

   #Find small dinos
   puts '\n **********These are the dinos under 2 tons!*******************'
   dino_filter_object.find_small_dinos(4000).print_list

   #Use multiple filters
   puts '\n **********These are the carnivorous bipeds!*******************'   
   dino_filter_object.find_carnivores.find_bipeds.print_list

  # return dino_filter_object, dino_objects
  return dino_filter_object, dino_objects
   

end 
