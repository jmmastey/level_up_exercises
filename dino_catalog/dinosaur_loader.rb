require_relative 'dinosaur'
require_relative 'parser'
require_relative 'dinosaur_query'
require 'json'

class DinosaurLoader
  attr_accessor :dinosaurs

  def initialize(file)
    @dinosaurs = load(file)
  end

  def walking
    dinosaurs.select { |d| d.filter('walking', 'Biped') }
  end

  def carnivore
    dinosaurs.select { |d| d.filter('diet', 'Carnivore') }
  end

  def period
    print "Enter period:\n> "
    value = gets.chomp!
    dinosaurs.select { |d| d.contains('period', value) }
  end

  def big
    dinosaurs.select { |d| d.greater_than?('weight', 2000) }
  end

  def json
    JSON.generate(@dinosaurs.map(&:to_h))
  end

  def query
    query = DinosaurQuery.new(dinosaurs)
    query.process
  end

  private

  def load(file)
    parse_file(file).map { |dinosaur| Dinosaur.new(dinosaur) }
  end

  def parse_file(file)
    Parser.new(file).parse
  end
end
