require_relative 'catalog'
require 'table_print'

class Import
  CONVERT_AFRICAN_TABLE = {
    'Genus' => 'Name',
    'Carnivore' => 'Diet',
    'Weight' => 'Weight_in_lbs',
  }

  def initialize
    attrs = {}
    CSV.foreach("dinodex.csv", headers: true, converters: :all) do |row|
      name = row["NAME"] # || row["genius"]
      attrs[:period] = row["PERIOD"]
      attrs[:continent] = row["CONTINENT"]
      attrs[:diet] = row["DIET"]
      attrs[:weight] =  row["WEIGHT_IN_LBS"]
      attrs[:walking] = row["WALKING"]
      attrs[:description] = row["DESCRIPTION"]
      puts "added >>" + name
      Catalog.dinosaurs << Dinosaur.new(name, attrs)
    end
  tp Catalog.dinosaurs
  end
end

    # @store = csv_to_array(filename)
    #   @columns
    # end

    # def csv_to_array(file_location)
    #   csv = CSV.parse(File.open(file_location, 'r') { |f| f.read })
    #   titles = csv.shift
    #   titles = titles.map { |f| f.downcase.to_sym }
    #   @columns = titles
    #   csv.collect { |record| Hash[*titles.zip(record).flatten(1)] }
    # end
