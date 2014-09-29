class Dinodex
  attr_accessor :dinosaurs

  def initialize(dinosaurs)
    @dinosaurs = dinosaurs
  end

  def filter(filter, value)
    #dinosaurs
  end

  def to_s()
    dinosaurs.each { |dinosaur| puts dinosaur.to_s}
  end
end