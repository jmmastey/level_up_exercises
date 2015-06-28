class UserRowReader < DinosaurRowReader
  def parse_row(row)
      dino = Dinosaur.new(row['NAME'])
      dino.period = row['PERIOD']
      dino.continent = row['CONTINENT']
      dino.diet = row['DIET']
      dino.weight = row['WEIGHT_IN_LBS']
      dino.walking = row['WALKING']
      dino.description = row['DESCRIPTION']
      dino
    end

  end

