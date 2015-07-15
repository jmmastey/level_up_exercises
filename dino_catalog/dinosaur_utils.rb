class DinosaurUtils
  TWO_TONS = 4000
  def self.dinosaur_list_by_walking(walking_type, dinosaurs)
    return [] if walking_type.nil?
    dino_list = []
    dinosaurs.each do |dinosaur|
      dino_list << dinosaur.name if dinosaur.walking == walking_type
    end
    dino_list
  end

  def self.dinosaur_list_from_period(period, dinosaurs)
    return [] if period.nil?
    dinosaur_list = []
    dinosaurs.each do |dinosaur|
      dinosaur_list << dinosaur.name if dinosaur.period.include?(period)
    end
    dinosaur_list
  end

  def self.dinosaur_list_from_diet(diet, dinosaurs)
    return [] if diet.nil?
    dinosaur_list = []
    dinosaurs.each do |dinosaur|
      dinosaur_list << dinosaur.name if dinosaur.diet.downcase == diet.downcase
    end
    dinosaur_list
  end

  def self.big_dino_list(dinosaurs)
    big_dinosaur_list = []
    dinosaurs.each do |dinosaur|
      big_dinosaur_list << dinosaur.name if greater_than_two_tons?(dinosaur)
    end
    big_dinosaur_list
  end

  def self.small_dino_list(dinosaurs)
    small_dinosaur_list = []
    dinosaurs.each do |dinosaur|
      small_dinosaur_list << dinosaur.name if two_tons_or_less?(dinosaur)
    end
    small_dinosaur_list
  end

  def self.two_tons_or_less?(dinosaur)
    dinosaur.weight && dinosaur.weight.to_i <= TWO_TONS
  end

  def self.greater_than_two_tons?(dinosaur)
    dinosaur.weight && dinosaur.weight.to_i > TWO_TONS
  end

  def self.dinosaur_list_by_continent(continent, dinosaurs)
    return [] if continent.nil?
    dinosaur_list = []
    dinosaurs.each do |dinosaur|
      dinosaur_list << dinosaur.name if dinosaur.continent == continent
    end
    dinosaur_list
  end

  def self.dinosaur_list_by_weight(weight, dinosaurs)
    return [] if weight.nil?
    big_dino_list(dinosaurs) if weight > TWO_TONS
    small_dino_list(dinosaurs) if weight <= TWO_TONS
  end

  def self.list_of_dinosaurs_by_criteria(criteria, dinosaurs)
    criteria[:name].nil? ? dino_array = [] : dino_array = [[criteria[:name]]]
    dino_array << dinosaur_list_from_period(criteria[:period], dinosaurs)
    dino_array << dinosaur_list_by_weight(criteria[:weight], dinosaurs)
    dino_array << dinosaur_list_by_walking(criteria[:walking], dinosaurs)
    dino_array << dinosaur_list_from_diet(criteria[:diet], dinosaurs)
    dino_array << dinosaur_list_by_continent(criteria[:continent], dinosaurs)
    get_common_dinosaurs_in_lists(remove_empty_sets(dino_array))
  end

  def self.remove_empty_sets(list_of_sets)
    list_of_sets.delete_if { |list| list.nil? || list.empty? }
    list_of_sets
  end

  def self.get_common_dinosaurs_in_lists(list_set)
    dinosaur_list = list_set.first unless list_set.empty?
    list_set.each do |list|
      dinosaur_list &= list
    end
    dinosaur_list
  end
end
