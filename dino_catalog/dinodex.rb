class Dinodex
  TON_AS_POUNDS = 2204

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
    end

    @dinosaurs.each do |dinosaur|
      if dinosaur.send("#{filter}")
        #TODO figure out better way to filter by weight (an int)
        if filter == :weight
          if value == 'big' && (dinosaur.send("#{filter}").to_i > (TON_AS_POUNDS * 2))
            results << dinosaur
          elsif value == 'small' && (dinosaur.send("#{filter}").to_i <= (TON_AS_POUNDS * 2))
            results << dinosaur
          end
        else
          if value.include? dinosaur.send("#{filter}")
            results << dinosaur
          end
        end
      end
    end

    @dinosaurs = results

    self
  end

  def to_s()
    @dinosaurs.each { |dinosaur| dinosaur.to_s}
  end
end