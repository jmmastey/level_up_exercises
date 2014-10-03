# Class user to map the African csv file to the Dinosaur domain object.
class AfricanMapper
  HEADER = %w(Genus Period Carnivore Weight Walking)

  PARSER = lambda do | data |
    Hash[
      name: data['Genus'],
      period: data['Period'],
      diet: to_diet(data['Carnivore']),
      weight: data['Weight'],
      walking: data['Walking']]
  end

  def self.mapper
    { HEADER => PARSER }
  end

  def self.to_diet(data)
    if data == 'Yes'
      'Carnivore'
    else
      'Herbivore'
    end
  end
end
