require './dinodex.rb'
require './dino.rb'
require './dinoparse.rb'

# SETUP
file1 = 'dinodex.csv'
file2 = 'african_dinosaur_export.csv'

dinos1 = Dinoparse.new(file1).dinos
dinos2 = Dinoparse.new(file2).dinos

dinodex = Dinodex.new(dinos1 + dinos2)

# QUERIES
puts "Grab all dinosaurs that were bipeds"
puts "-" * 20
dinodex.equal('walking', 'biped').index
puts

puts "Grab all the dinosaurs that were carnivores (fish and insects count)"
puts "-" * 20
dinodex.not_equal('diet', 'herbivore').index
puts

puts "Grab dinosaurs for specific periods (no need to \
differentiate between early and late cretaceous, btw.)"
puts "-" * 20
dinodex.like('period', 'cretaceous').index
puts

puts "Grab only big (> 2 tons) or small dinosaurs."
puts "-" * 20
dinodex.greater_than('weight', '4000').index
puts

puts "Just to be sure, I'd love to be able to combine criteria at will, \
even better if I can chain filter calls together"
puts "-" * 20
dinodex.like('name', 'D...o')
  .like('period', 'early')
  .like('continent', 'america').index
puts

puts "Another example of chaining."
puts "-" * 20
dinodex.like('name', 'saurus')
  .greater_or_equal('weight', '10000').index
puts

puts "I would love to have a way to do (and chain) generic \
search by parameters. I can pass in a hash, and I'd like to \
get the proper list of dinos back out."
puts "-" * 20
dinodex.search('diet' => 'carnivore', 'continent' => 'europe').index
puts

puts "CSV isn't may favorite format in the world. Can \
you implement a JSON export feature?"
puts "-" * 20
puts dinodex.not_like('continent', 'America').json
puts

# DONE
