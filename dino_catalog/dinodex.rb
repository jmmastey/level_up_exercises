require "json"

class Dinodex
  def initialize(dinosaurs)
    @dinosaurs = dinosaurs
  end

  def filter(filter, value)
    results = []

    filter, value = filter_overrides(filter, value)

    @dinosaurs.each do |dinosaur|
      dino_val = dinosaur.send("#{filter}")
      results << dinosaur if (dino_val) && (value.include? dino_val)
    end

    Dinodex.new(results)
  end

  def filter_overrides(filter, value)
    case filter
      when :diet
        %w(Carnivore Insectivore Piscivore) if value == "Carnivore"
      when :period
        value = ["Early " + value, value, "Late " + value]
    end

    [filter, value]
  end

  def to_s
    @dinosaurs.join("\n\n")
  end

  def to_json(*args)
    @dinosaurs.to_json(*args)
  end
end
