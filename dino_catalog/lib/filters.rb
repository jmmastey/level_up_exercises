module Filters

  def list_bipeds
      bipeds = @catalog.dinosaurs.select { |dinosaur| dinosaur.walking == 'Biped' }
      print "\nThe following dinosaurs are bipeds: \n\n"
      print "Sorry. No bipeds were found" if bipeds.empty?
      bipeds.each do |dinosaur|
        puts "#{dinosaur.name}"
      end
    end

    def list_carnivores
      carnivores = @catalog.dinosaurs.select { |dinosaur| CARNIVORES.include?(dinosaur.diet) }
      print "\nThe following dinosaurs are Carnivores, Insectivores, or Piscivores: \n\n"
      print "Sorry. No carnivores were found" if carnivores.empty?
      carnivores.each do |dinosaur|
        puts "#{dinosaur.name}"
      end
    end

    def list_period(period)
      dinosaurs_in_period = @catalog.dinosaurs.select { |dinosaur| dinosaur.period.downcase =~ /#{period}/ }
      print "\nThe following dinosaurs lived in the #{period.capitalize} period: \n\n"
      print "Sorry. No dinosaurs were found" if dinosaurs_in_period.empty?
      dinosaurs_in_period.each do |dinosaur|
        puts "#{dinosaur.name}"
      end
    end

    def list_size(size)
      dinosaurs_by_size = @catalog.dinosaurs.partition { |dinosaur| dinosaur.big? }
      if size == 'big'
        dinosaur_size_subset = dinosaurs_by_size[0]
      else
        dinosaur_size_subset = dinosaurs_by_size[1].select { |dino| dino.weight_in_lbs }
      end
      print "\nThe following dinosaurs were #{size.capitalize}: \n\n"
      print "Sorry. No dinosaurs were found" if dinosaurs_by_size.empty?
      dinosaur_size_subset.each do |dinosaur|
        puts "#{dinosaur.name}"
      end
    end

end
