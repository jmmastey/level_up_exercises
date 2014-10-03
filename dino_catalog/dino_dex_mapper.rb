# Class that maps dinodex.csv file to the dinosaur domain object.
class DinoDexMapper
  HEADER = %w(NAME PERIOD CONTINENT DIET WEIGHT_IN_LBS WALKING DESCRIPTION)

  MAPPER = lambda do | data |
    Hash[
      name: data['NAME'],
      period:  data['PERIOD'],
      continent:  data['CONTINENT'],
      diet:  data['DIET'],
      weight: data['WEIGHT_IN_LBS'],
      walking: data['WALKING'],
      description: data['DESCRIPTION']]
  end

  def self. mapper
    { HEADER => MAPPER }
  end
end
