require_relative 'dino.rb'
require_relative 'filter.rb'

class Utility
  def self.verify_file(file_array)
    file_array.delete_if { |file| !File.exist?(file) }
  end

  def self.read_in(file_array)
    dino_arr = []
    file_array.each do|file|

      CSV.foreach(file, headers: true) do |row|

        name = row['Genus'] || row['NAME']
        period = row['Period'] || row['PERIOD']
        continent = row['CONTINENT']
        diet = row['Carnivore'] || row['DIET']
        weight = row['Weight'] || row['WEIGHT_IN_LBS']
        walking = row['Walking'] || row['WALKING']
        description = row['DESCRIPTION']

        dino_arr << Dino.new(name: name, period: period,\
        continent: continent, diet: diet, weight: weight,\
        walking: walking, description: description)
      end

    end
    # Think about inserting a row with the apporaite table columns.
    dino_arr
  end

  def self.pass_off_filters(options, dino_arr)
    options.to_h.each do |catagory, term|
      Filter.filter_by_walking(dino_arr, term) if catagory.to_s.eql?("Walking")
      Filter.filter_by_weight(dino_arr, term) if catagory.to_s.eql?("Weight")
      Filter.filter_by_diet(dino_arr, term) if catagory.to_s.eql?("Diet")
      Filter.filter_by_period(dino_arr, term) if catagory.to_s.eql?("Period")
    end
    dino_arr
  end

  def self.print(dino_arr)
    puts dino_arr
    puts "Found Nothing uing the option flags inputed" if dino_arr.empty?
  end
end
