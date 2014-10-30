require_relative 'dino.rb'
require_relative 'filter.rb'

class Utility
  def self.verify_file(file_array)
    file_array.delete_if { |file| !File.exist?(file) }
  end

  def self.read_in(file_array)
    dinos = []
    file_array.each do|file|

      CSV.foreach(file, headers: true) do |row|
        name = row['Genus'] || row['NAME']
        period = row['Period'] || row['PERIOD']
        continent = row['CONTINENT']
        diet = row['Carnivore'] || row['DIET']
        weight = row['Weight'] || row['WEIGHT_IN_LBS']
        walking = row['Walking'] || row['WALKING']
        description = row['DESCRIPTION']

        dinos << Dino.new(name: name,
                             period: period,
                             continent: continent,
                             diet: diet,
                             weight: weight,
                             walking: walking,
                             description: description)
      end

    end
    dinos
  end

  def self.pass_off_filters(options, dinos)
    options.to_h.each do |catagory, term|
      Filter.filter_by_walking(dinos, term) if catagory.to_s.eql?("Walking")
      Filter.filter_by_weight(dinos, term) if catagory.to_s.eql?("Weight")
      Filter.filter_by_diet(dinos, term) if catagory.to_s.eql?("Diet")
      Filter.filter_by_period(dinos, term) if catagory.to_s.eql?("Period")
    end
    dinos
  end

  def self.print(dinos)
    puts dinos
    puts "Found Nothing uing the option flags inputed" if dinos.empty?
  end
end
