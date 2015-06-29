class PirateBayRowReader < DinosaurRowReader
  def parse_row(row)
    dino = Dinosaur.new(row['Genus'])
    dino.period = row['Period']
    dino.diet = diet row['Carnivore']
    dino.weight = row['Weight']
    dino.walking = row['Walking']
    dino
  end

  def diet(carnivore_text)
    carnivore_text == 'Yes' ? ('Carnivore') : ('Vegetarian')
  end
end
