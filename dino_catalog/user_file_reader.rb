class UserFileReader < DinosaurFileReader
  def parse_raw_data
    dinosaurs = []
    values.each do |row|
      dino = Dinosaur.new(row['NAME'])
      dino.period = row['PERIOD']
      dino.continent = row['CONTINENT']
      dino.diet = row['DIET']
      dino.weight = row['WEIGHT_IN_LBS']
      dino.walking = row['WALKING']
      dino.description = row['DESCRIPTION']
      dinosaurs << dino
    end
    dinosaurs
  end
end
