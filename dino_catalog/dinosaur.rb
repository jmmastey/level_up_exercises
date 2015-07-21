# Dinosaur Class. We store these dinosaurs in an array in
# order to query the array.

class Dinosaur
  def initialize(info)
    @name = info['Name']
    @period = info['Period']
    @continent = info['Continent']
    @diet = info['Diet']
    @weight = info['Weight_in_lbs']
    @walking = info['Walking']
    @description = info['Description'] || ''
    capitalize_relevant_members
  end

  def setup_diet(diet)
    @diet = diet unless diet == 'Yes' || diet == 'No'
    @diet = 'Carnivore' if diet == 'Yes'
    @diet = 'Herbivore' if diet == 'No'
  end

  def capitalize_relevant_members
    @period.split.map(&:capitalize).join(' ')
    @continent.split.map(&:capitalize).join(' ')
  end

  def to_s
    row = ''
    instance_variables.each do |var|
      value = instance_variable_get(var)
      row << "#{var}: #{value} " unless value == ''
    end
    row.delete('@')
  end

  def walking_type?(type)
    @walking == type.capitalize
  end

  def carnivore?
    %w(Carnivore Piscivore Insectivore).include?(@diet)
  end

  def in_period?(period)
    @period.downcase.include?(period.downcase)
  end

  def above_weight?(weight)
    @weight.to_i >= weight.to_i
  end

  def below_weight?(weight)
    @weight.to_i <= weight.to_i
  end
end
