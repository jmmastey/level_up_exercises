class Dinodex
  attr_accessor :dinosaurs

  LARGE_WEIGHT = 2000

  def initialize(dinosaurs)
    @dinosaurs = dinosaurs
  end

  def formetted_print_all_dinos
    @dinosaurs.each do |dino|
      dino.formatted_variables.each { |attri| puts attri }
      puts "\n----------\n\n"
    end
  end

  def bipeds
    bipeds = dinosaurs.select { |dino| dino.walking == 'Biped' }
    Dinodex.new(bipeds)
  end

  def carnivores
    carnivores = dinosaurs.select { |dino| dino.carnivore == 'Yes' }
    Dinodex.new(carnivores)
  end

  def period(p)
    from_period = dinosaurs.select do |dino|
     dino.period.downcase.include? p.downcase
    end
    Dinodex.new(from_period)
  end

  def small_dinosaurs
    smalls = dinosaurs.select { |dino| dino.weight <= LARGE_WEIGHT }
    Dinodex.new(smalls)
  end

  def large_dionsaurs
    larges = dinosaurs.select { |dino| dino.weight > LARGE_WEIGHT }
    Dinodex.new(larges)
  end
end
