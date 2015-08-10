require_relative 'dinosaur'
require_relative 'parser'
require_relative 'dinosaur_query'
require 'json'

class DinosaurInterface
  attr_accessor :dinosaurs
  ONE_TON_IN_POUNDS = 2000

  def initialize
    @dinosaurs = []
  end

  def add_dinosaurs(file)
    dinosaurs.concat(load(file))
  end

  def bipeds
    dinosaurs.select { |d| d.eql?('walking', 'Biped') }
  end

  def carnivores
    dinosaurs.select { |d| d.eql?('diet', 'Carnivore') }
  end

  def period
    dinosaurs.select { |d| d.contains('period', ask_user_for_period) }
  end

  def ask_user_for_period
    print "Enter period:\n> "
    gets.chomp!
  end

  def big
    dinosaurs.select { |d| d.greater_than?('weight', 2 * ONE_TON_IN_POUNDS) }
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
    parse_file(file).map { |attributes| Dinosaur.new(attributes) }
  end

  def parse_file(file)
    Parser.new(file).parse
  end
end
