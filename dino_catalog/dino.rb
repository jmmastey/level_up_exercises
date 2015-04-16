class Dino
  require 'csv'
  attr_accessor :dinos

  def initialize(file, headers)
    @dinos = CSV.read(file, headers)
    @dinos.headers.each(&:upcase!)
  end

  def bipeds
    bipeds = []
    dinos.map do |e|
      bipeds << e if e['WALKING'] == 'Biped'
    end
    bipeds.join
  end

  def carnivores
    carnivores = []
    dinos.map do |e|
      carnivores << e if e['DIET'] == 'Carnivore'
    end
    carnivores.join
  end

  def big_or_small
    big_or_small = []
    dinos.map do |e|
      big_or_small << e if e['WEIGHT_IN_LBS'].to_i > 4000 ||
                           e['WEIGHT_IN_LBS'].to_i < 500 unless
      e['WEIGHT_IN_LBS'].nil?
    end
    big_or_small.join
  end

  def from_jurassic
    jurassic = []
    dinos.map { |e| jurassic << e if e['PERIOD'] =~ /Jurassic/ }
    jurassic.join
  end

  def from_cretaceous
    cretaceous = []
    dinos.map { |e| cretaceous << e if e['PERIOD'] =~ /Cretaceous/ }
    cretaceous.join
  end

  def from_late_permian
    late_permian = []
    dinos.map { |e| late_permian << e if e['PERIOD'] == 'Late Permian' }
    late_permian.join
  end

  def from_oxfordian
    oxfordian = []
    dinos.map { |e| oxfordian << e if e['PERIOD'] == 'Oxfordian' }
    oxfordian.join
  end
end
dinos = Dino.new('dinodex.csv', headers: true)
puts dinos.from_late_permian
