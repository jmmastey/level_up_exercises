class Dinos
  require 'csv'
  attr_accessor :dinos

  def initialize(file, headers)
    @dinos = CSV.read(file, headers)
    @dinos.headers.each { |e| e.upcase! }
  end

  def bipeds
    bipeds = []
    dinos.collect do |e|
      bipeds << e if e['WALKING'] == 'Biped'
    end
    bipeds.join
  end

  def carnivores
    carnivores = []
    dinos.collect do |e|
      carnivores << e if e['DIET'] == 'Carnivore'
    end
    carnivores.join
  end

  def big_or_small
    big_or_small = []
    dinos.collect do |e|
      big_or_small << e if e['WEIGHT_IN_LBS'].to_i > 4000 ||
                           e['WEIGHT_IN_LBS'].to_i < 500 unless e['WEIGHT_IN_LBS'].nil?
    end
    big_or_small.join
  end

  def period(arg)
    period = []
    case arg
      when 'Jurassic'
        dinos.collect { |e| period << e if e['PERIOD'] =~ /Jurassic/ }
      when 'Late Permian'
        dinos.collect { |e| period << e if e['PERIOD'] == 'Late Permian' }
      when 'Cretaceous'
        dinos.collect { |e| period << e if e['PERIOD'] =~ /Cretaceous/ }
      when 'Oxfordian'
        dinos.collect { |e| period << e if e['PERIOD'] == 'Oxfordian' }
    end
    period.join
  end
end

class African < Dinos
  def carnivores
    carnivores = []
    dinos.collect do |e|
      carnivores << e if e['Carnivore'] == 'Yes'
    end
    carnivores.join
  end

  def period(arg)
    period = []
    case arg
      when 'Jurassic'
        dinos.collect { |e| period << e if e['PERIOD'] =~ /Jurassic/ }
      when 'Albian'
        dinos.collect { |e| period << e if e['PERIOD'] == 'Albian' }
      when 'Cretaceous'
        dinos.collect { |e| period << e if e['PERIOD'] =~ /Cretaceous/ }
      when 'Triassic'
        dinos.collect { |e| period << e if e['PERIOD'] == 'Triassic' }
    end
    period.join
  end
end
