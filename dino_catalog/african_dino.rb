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
        big_or_small << e if e['WEIGHT'].to_i > 4000 || e['WEIGHT'].to_i < 500 unless e['WEIGHT'].nil?
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

african_dino = African.new('african_dinosaur_export.csv', headers: true)
puts african_dino.carnivores
