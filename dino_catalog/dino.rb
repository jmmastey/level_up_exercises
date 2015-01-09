require 'csv'
require 'pry'

class Dinodex

  def read_csv
    arr = []
    CSV.foreach('african_dinosaur_export.csv', headers: true) { |i| arr << i.to_h }

    arr.map { |i| Hash[i.map { |k,v| [k.downcase.to_sym, v] }] }
  end

  def all
    @all ||= read_csv.map { |hash| Dino.new(hash) }
  end

  def bipeds
    all.select(&:biped?)
  end

  def carnivores
    all.select(&:carnivore?)
  end

  def big
    all.select(&:big?)
  end

  def small
    all.select(&:small?)
  end
end

class Dino
  attr_reader :name, :period, :continent, :diet, :weight, :walking, :description

  def initialize(args={})
    @name             = args[:name]   || args[:genus]
    @period           = args[:period]
    @continent        = args[:continent]
    @diet             = args[:diet]   || ('Carnivore' if args[:carnivore] == 'yes')
    @weight           = args[:weight] || args[:weight_in_pounds]
    @walking          = args[:walking]
    @description      = args[:description]
  end

  def biped?
    walking == 'Biped'
  end

  def carnivore?
    ['Carnivore', 'Insectivore', 'Piscivore'].includes? diet
  end

  def big?
    weight.to_i > 2000 if weight
  end

  def small?
    weight.to_i <= 2000 if weight
  end
end

dinodex = Dinodex.new
puts dinodex.all
# puts dinodex.bipeds.count