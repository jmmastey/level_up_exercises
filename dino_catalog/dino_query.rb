require_relative './parse.rb'
require_relative './dinosaur.rb'

class DinoQuery
  attr_accessor :dinos

  def initialize(dinos = [])
    @dinos = get_dinos(dinos)
  end

  def get_dinos(dinos)
    return dinos unless dinos.empty?
    parser = Parser.new
    parser.parse
    parser.dinos
  end

  def biped
    results = dinos & dinos.select(&:biped?)
    DinoQuery.new(results)
  end

  def carnivore
    results = dinos & dinos.select(&:carnivore?)
    DinoQuery.new(results)
  end

  def big
    results = dinos & dinos.select(&:big?)
    DinoQuery.new(results)
  end

  def small
    results = dinos & dinos.select(&:small?)
    DinoQuery.new(results)
  end

  def from_period(prd)
    results = dinos & dinos.select { |d| d.from_period?(prd) }
    DinoQuery.new(results)
  end

  def print
    dinos.each(&:print_facts)
    nil
  end

  def to_json
    dinos.map(&:to_json)
  end
end

# Tests
# dq = DinoQuery.new
# dq.from_period("Jurassic").small.print
# dq.biped.big.print
# dq.carnivore.from_period("Cretaceous").print
