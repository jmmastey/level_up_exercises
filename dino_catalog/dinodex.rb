require 'csv'

class Dinosaur
    attr_reader :name
  def initialize(options)
    @name = options["NAME"].to_s
    @period = options["PERIOD"].to_s
    @continent = options["CONTINENT"].to_s
    @diet = options["DIET"].to_s
    @weight_in_lbs = options["WEIGHT_IN_LBS"].to_i
    @legs = convert(options["WALKING"])
    @description = options["DESCRIPTION"].to_s
  end


  def convert(dino)
    if dino.downcase == "biped"
      2
    elsif dino.downcase == "quadruped"
      4
    else
      "other"
    end
  end
end

dinosaurs = CSV.read('dinodex.csv', headers:true)

p dinosaurs
library = []
dinosaurs.each do |dino|
    row =dino.to_hash
    library << Dinosaur.new(row)

end


# p library[4]
