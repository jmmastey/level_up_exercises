require "json"

class Dinodex
  def initialize(dinosaurs)
    @dinosaurs = dinosaurs
  end

  def filter(filter, value)
    results = []

    #Check for special filtering cases
    filter, value = filter_overrides(filter, value)

    @dinosaurs.each do |dinosaur|
      if (dinosaur.send("#{filter}")) && (value.include? dinosaur.send("#{filter}"))
        results << dinosaur
      end
    end

    Dinodex.new(results)
  end

  def filter_overrides(filter, value)
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

    [filter, value]
  end

  def to_s
    @dinosaurs.join("\n")
  end

  def to_json(*args)
    @dinosaurs.to_json(*args)
  end
end
