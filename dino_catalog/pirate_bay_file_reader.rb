class PirateBayFileReader < DinosaurFileReader
  def parse_raw_data
    dinosaurs = []
    values.each do |row|
      dino = Dinosaur.new(row['Genus'])
      dino.period = row['Period']
      row['Carnivore'] == 'Yes' ? (dino.diet = 'Carnivore') : (dino.diet = 'Vegetarian')
      dino.weight = row['Weight']
      dino.walking = row['Walking']
      dinosaurs << dino
    end
    dinosaurs
  end
end
