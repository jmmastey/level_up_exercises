# Dinosaur Class. We store these dinosaurs in an array in
# order to query the array.

class Dinosaur
  def initialize(info)
    @name = info['Name']
    @period = info['Period']
    @continent = info['Continent'] || ''
    setup_diet(info['Diet'])
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
    name_to_s + period_to_s + continent_to_s + diet_to_s + \
      weight_to_s + walking_to_s + description_to_s
  end

  def name_to_s
    'Name: ' + @name
  end

  def period_to_s
    if @period == ''
      ''
    else
      ' Period: ' + @period
    end
  end

  def continent_to_s
    if @continent == ''
      ''
    else
      ' Continent: ' + @continent
    end
  end

  def diet_to_s
    if @diet == ''
      ''
    else
      ' Diet: ' + @diet
    end
  end

  def weight_to_s
    if @weight == ''
      ''
    else
      ' Weight: ' + @weight
    end
  end

  def walking_to_s
    if @walking == ''
      ''
    else
      ' Walking: ' + @walking
    end
  end

  def description_to_s
    if @description == ''
      ''
    else
      ' Description: ' + @description
    end
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
    @weight.to_i > weight.to_i
  end

  def below_weight?(weight)
    @weight.to_i < weight.to_i
  end
end
