class PirateBayFileReader < DinosaurFileReader
  def parse_raw_data
    dinosaurs = []
    values.each do |row|
      dino = Dinosaur.new(row[0])
      dino.period = row[1]
      row[2] == 'Yes' ? (dino.diet = 'Carnivore') : (dino.diet = 'Vegetarian')
      dino.weight = row[3]
      dino.walking = row[4]
      dinosaurs << dino
    end
    dinosaurs.delete_at(0)
    dinosaurs
  end
end
