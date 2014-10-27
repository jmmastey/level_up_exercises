module Filters

  CARNIVORES = ['Carnivore', 'Insectivore', 'Piscivore']

  def filter_bipeds(biped_terms)
    dinosaurs.select { |dinosaur| biped_terms.include? dinosaur.walking.downcase }
  end

  def filter_carnivores(carnivore_terms)
    dinosaurs.select { |dinosaur| CARNIVORES.include?(dinosaur.diet) }
  end

  def filter_period(period_terms)
    periods_in_regex_array = Regexp.union(period_terms)
    dinosaurs.select { |dinosaur| dinosaur.period.downcase.match(periods_in_regex_array) }
  end

  def filter_size
    dinosaurs.partition { |dinosaur| dinosaur.big? }
    if size == 'big'
      dinosaur_size_subset = dinosaurs_by_size[0]
    else
      dinosaur_size_subset = dinosaurs_by_size[1].select { |dino| dino.weight_in_lbs }
    end
  end

end
