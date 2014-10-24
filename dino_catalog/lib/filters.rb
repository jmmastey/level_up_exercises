module Filters

  CARNIVORES = ['Carnivore', 'Insectivore', 'Piscivore']

  def filter_bipeds
    dinosaurs.select { |dinosaur| dinosaur.walking == 'Biped' }
  end

  def filter_carnivores
    dinosaurs.select { |dinosaur| CARNIVORES.include?(dinosaur.diet) }
  end

  def filter_period(period)
    dinosaurs_in_period = @catalog.dinosaurs.select { |dinosaur| dinosaur.period.downcase =~ /#{period}/ }
    print "\nThe following dinosaurs lived in the #{period.capitalize} period: \n\n"
    print "Sorry. No dinosaurs were found" if dinosaurs_in_period.empty?
    dinosaurs_in_period.each do |dinosaur|
      puts "#{dinosaur.name}"
    end
  end

  def filter_size(size)
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
