require 'json'

class Dinodex
  def initialize(dinosaurs)
    @dinosaurs = dinosaurs
  end

  def filter(filter, value)
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
      if (dinosaur.send("#{filter}")) && (value.include? dinosaur.send("#{filter}"))
        results << dinosaur
      end
    end

    Dinodex.new(results)
  end

  def to_s
    @dinosaurs.join("\n")
  end

  def to_json
    output = []

    @dinosaurs.each { |dinosaur| output <<dinosaur.to_hash.to_json }

    output.join("")
  end
end
