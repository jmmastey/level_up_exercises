require_relative 'dino'
class African < Dino
  def carnivores
    carnivores = []
    dinos.map do |e|
      carnivores << e if e['CARNIVORE'] == 'Yes'
    end
    carnivores.join
  end

  def big_or_small
    big_or_small = []
    dinos.map do |e|
      if e['WEIGHT'].to_i > 4000 || e['WEIGHT'].to_i < 500 && e['WEIGHT'].nil?
        big_or_small << e
      end
    end
    big_or_small.join
  end

  def from_jurassic
    dinos.map { |e| period << e if e['PERIOD'] =~ /Jurassic/ }
  end

  def from_albian
    albian = []
    dinos.map { |e| albian << e if e['PERIOD'] == 'Albian' }
    albian.join
  end

  def from_cretaceous
    cretaceous = []
    dinos.map { |e| cretaceous << e if e['PERIOD'] =~ /Cretaceous/ }
    cretaceous.join
  end

  def from_triassic
    triassic = []
    dinos.map { |e| triassic << e if e['PERIOD'] == 'Triassic' }
    triassic.join
  end
end
