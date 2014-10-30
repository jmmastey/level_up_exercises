class Filter
  def self.filter_by_period(dinos, period)
    dinos.delete_if { |row|  !row.period.include? period }
  end

  def self.filter_by_continent(dinos, country)
    dinos.delete_if { |row| !row.continent.include? country }
  end

  def self.filter_by_walking(dinos, walking)
    dinos.delete_if { |row| !row.walking.include? walking }
  end

  def self.filter_by_weight(dinos, weight)
    dinos.delete_if { |row| row.weight.to_f > 2000 } if weight.eql?('Small')
    dinos.delete_if { |row| row.weight.to_f < 2000 } if weight.eql?('Big')
  end

  def self.filter_by_diet(dinos, meal)
    dinos.delete_if { |row| !row.diet.include? 'No' } if meal.eql?('Veg')
    dinos.delete_if { |row| row.diet.include? 'No' } if  meal.eql?('Carn')
  end
end
