class Filter
  def self.filter_by_period(dino_arr, period)
    dino_arr.delete_if { |row|  !row.period.include? period }
  end

  def self.filter_by_continent(dino_arr, country)
    dino_arr.delete_if { |row| !row.continent.include? country }
  end

  def self.filter_by_walking(dino_arr, walking)
    dino_arr.delete_if { |row| !row.walking.include? walking }
  end

  def self.filter_by_weight(dino_arr, weight)
    dino_arr.delete_if { |row| row.weight.to_f > 2000 } if weight.eql?('Small')
    dino_arr.delete_if { |row| row.weight.to_f < 2000 } if weight.eql?('Big')
  end

  def self.filter_by_diet(dino_arr, meal)
    dino_arr.delete_if { |row| !row.diet.include? 'No' } if meal.eql?('Veg')
    dino_arr.delete_if { |row| row.diet.include? 'No' } if  meal.eql?('Carn')
  end
end
