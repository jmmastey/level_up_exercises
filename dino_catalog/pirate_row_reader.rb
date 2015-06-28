class PirateBayRowReader < DinosaurRowReader

  def parse_row(row)
      dino = Dinosaur.new(row['Genus'])
      dino.period = row['Period']
      row['Carnivore'] == 'Yes' ? (dino.diet = 'Carnivore') : (dino.diet = 'Vegetarian')
      dino.weight = row['Weight']
      dino.walking = row['Walking']
      dino

  end
end
