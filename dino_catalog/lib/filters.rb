module Filters

  CARNIVORES = ['Carnivore', 'Insectivore', 'Piscivore']

  def filter_bipeds(biped_terms)
    dinosaurs.select { |dinosaur| biped_terms.include? dinosaur.walking.downcase }
  end

  def filter_carnivores(carnivore_terms)
    dinosaurs.select { |dinosaur| CARNIVORES.include?(dinosaur.diet) }
  end

  def filter_periods(period_terms)
    periods_in_regex_array = Regexp.union(period_terms)
    dinosaurs.select { |dinosaur| dinosaur.period.downcase.match(periods_in_regex_array) }
  end

  def filter_sizes(size_terms)
    case
    when size_terms.include?('big')
      dinosaurs.select { |dinosaur| dinosaur.big? }
    when size_terms.include?('small')
      dinosaurs.select { |dinosaur| dinosaur.small? }
    end
  end

end
