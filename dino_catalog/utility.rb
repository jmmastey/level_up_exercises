class Utility

  def self.verify_file(file_array)
    file_array.each{|file| file_array.delete(file) if !File.exist?(file)}
  end

  def self.read_in(file_array, my_array) #seperate this off

  file_array.each {|file|
    CSV.foreach(file, headers: true) do |row|

      name= row['Genus'] || row['NAME']
      period=row['Period'] || row['PERIOD']
      continent=row['CONTINENT']
      diet=row['Carnivore'] || row['DIET']
      weight=row['Weight'] || row['WEIGHT_IN_LBS']
      walking=row['Walking'] || row['WALKING']
      description=row['DESCRIPTION']

      my_array<< Dino.new(name, period, continent, diet, weight, walking, description) #defaults come last

    end
    my_array

  }
  end #end read

  def self.pass_off_filters(options, my_array)

  options=options.to_h.each do |k,v|
      Filter.filter_by_walking(my_array, v) if k.to_s.eql?("Walking")
      Filter.filter_by_weight(my_array, v) if k.to_s.eql?("Weight")
      Filter.filter_by_diet(my_array, v) if k.to_s.eql?("Diet")
      Filter.filter_by_period(my_array, v) if k.to_s.eql?("Period")
    end
    my_array
  end #pass off

  def self.print(my_array)
    puts my_array
    puts "Found Nothing uing the option flags inputed" if my_array.empty?
  end  #end print


end

