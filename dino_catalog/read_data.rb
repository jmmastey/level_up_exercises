load 'dino_class.rb'
load 'dino_filters.rb'
require 'csv'

def read_data()

   #Make an list of dino_class objects
   dino_objects = []

   #Loop over the csv files.  Create dino object and append them to a list of dino objects
   CSV.foreach('dino_csv_list') do |new_file|
      filename = new_file[0]
      dino_data = CSV.read(filename, :headers => true, :header_converters => :symbol)
      dino_data.each do |row| 
         new_dino = Dinos.new(row.to_hash)
         dino_objects.push(new_dino)
      end
   end

   #Create Dino_filters object so that all the filter methods can be used
   dino_filter_object = Dino_filters.new(dino_objects)

   #return the dino objects so that they can be queried.
   return dino_filter_object, dino_objects

end
