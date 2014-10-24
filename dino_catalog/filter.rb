class Filter

  def self.filter_by_period(my_array, period)
    my_array.delete_if {|row|  !row.period.include? period}
  end

  def self.filter_by_continent(my_array, country)
    my_array.delete_if {|row| !row.continent.include? country}
  end

  def self.filter_by_walking(my_array, walking)
    my_array.delete_if {|row| !row.walking.include? walking}
  end

  def self.filter_by_weight(my_array, weight_type)
    weight=2000
    my_array.delete_if {|row| row.weight.to_f > weight} if weight_type.eql?('Small')
    my_array.delete_if {|row| row.weight.to_f < weight} if weight_type.eql?('Big')
  end

  def self.filter_by_diet(my_array, diet_type)
    my_array.delete_if {|row| !row.diet.include? 'No' } if diet_type.eql?('Veg')
    my_array.delete_if {|row| row.diet.include? 'No' } if diet_type.eql?('Carn')
  end

end
