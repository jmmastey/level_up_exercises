require 'json'
require './dinosaur'

class DinosaurCollection
  attr_accessor :dinosaurs

  def initialize(dinosaurs = [])
    @dinosaurs = dinosaurs
  end

  def find(condition = nil)
    dinosaurs_found = DinosaurCollection.new(@dinosaurs)

    return dinosaurs_found unless condition
    raise "find condition must be a hash" unless condition.is_a? Hash

    dinosaurs_found.dinosaurs = @dinosaurs

    condition.map do |attr, val|
      dinosaurs_found.dinosaurs = 
        dinosaurs_found.dinosaurs.select do |dino_obj|
          (ret = dino_obj.send(attr)) && ret.downcase == val.downcase
        end
    end

    dinosaurs_found
  end

  TONS_TO_POUNDS = 2000
  def find_large
    dinosaurs_found = DinosaurCollection.new(@dinosaurs)

    dinosaurs_found.dinosaurs.select do |dino_obj|
      dino_obj.weight > 2 * TONS_TO_POUNDS
    end
  end

  def to_s
    @dinosaurs.inject('') { |string, dino| string << dino.to_s }
  end

  def to_json
    @dinosaurs.map { |dino| dino.to_json }
  end
end
