class UserFileReader < DinosaurFileReader
  def parse_raw_data
    dinosaurs = []
    values.each do |row|
      dino = Dinosaur.new(row[0])
      dino.period = row[1]
      dino.continent = row[2]
      dino.diet = row[3]
      dino.weight = row[4]
      dino.walking = row[5]
      dino.description = row[6]
      dinosaurs << dino
    end
    dinosaurs
  end
end
