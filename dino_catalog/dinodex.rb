require 'json'

class Dinodex
  def initialize(dinosaurs)
    @dinosaurs = dinosaurs
  end

  def filter(filter, value)
    #Display filter and value on front-end
    puts "+ Filtering " + filter.to_s + " on " + value.to_s

    results = []

    #Check for special filtering cases
    case filter
      when :diet
        if value == "Carnivore"
          value = ["Carnivore", "Insectivore", "Piscivore"]
        end
      when :period
        value = ["Early " + value, value, "Late " + value]
      when :weight
        filter = :weight_classification
    end

    #Look through collection for Dinosaurs that match criteria
    @dinosaurs.each do |dinosaur|
      if dinosaur.send("#{filter}")
        if value.include? dinosaur.send("#{filter}")
          results << dinosaur
        end
      end
    end

    @dinosaurs = results

    #Send back self to allow chaining of filter()
    self
  end

  def to_s()
    @dinosaurs.each { |dinosaur| dinosaur.to_s}
  end

  def to_json()
    @dinosaurs.each { |dinosaur| puts JSON.generate(dinosaur.to_hash) }
  end
end