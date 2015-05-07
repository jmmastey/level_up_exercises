require './dinodex'

dinodex = DinoDex.new

# Grab all dinosaurs that were bipeds
# p dinodex.search('walking' => 'Biped')

# # Grab all the dinosaurs that were carnivores (fish and insects count).
# p dinodex.search('diet' => %w(Carnivore Insectivore Piscivore))

# # Grab dinosaurs for specific periods
# p dinodex.search('period' => 'Cretaceous')

# # Grab only big (> 2 tons) or small dinosaurs.
# p dinodex.search('min_weight' => 2000)

# # Print out details of a specific dinosaur
# p dinodex.search('name' => 'Albertonykus')

# Now, multiple filters!!

dinodex.search(
  'period' => 'Cretaceous',
  'walking' => 'Biped',
)
