require 'csv'
#
class Dinosaur
    attr_reader :name
  def initialize(options)
    @name = options[:name].to_s
    @period = options[:period].to_s
    @continent = options[:continent].to_s
    @diet = options[:diet].to_s
    @weight_in_lbs = options[:weight_in_lbs].to_i
    @legs = convert_legs(options[:walking])
    @description = options[:description].to_s
  end


  def convert_legs(dino)
    if dino.downcase == "biped"
      2
    elsif dino.downcase == "quadruped"
      4
    else
      "other"
    end
  end
end

class Library
  def initialize
  end

  def parser(file)
    dinosaurs = CSV.read(file, headers:true)

    dinosaurs.each do |dino|
        row = dino.to_hash
        mapping = {"Genus" => "Name", "Carnivore" => "Diet", "Weight" => "Weight_in_lbs"}
        row.keys.each { |k| row[mapping[k]] = row.delete(k) if mapping[k]}
        row = row.inject({}){|memo,(k,v)| memo[k.downcase.to_sym] = v; memo}
        library << Dinosaur.new(row)
    end
  end
end
p library
