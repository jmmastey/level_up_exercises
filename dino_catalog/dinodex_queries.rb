require_relative('dinodex.rb')

dex = DinodexParserCSV.new
list = dex.parse('african_dinosaur_export.csv')
dex = DinoDex.new(list)
puts 'All bipeds:'
dex.walking('Biped').print
puts 'All Carnivores:'
dex.carnivores.print
puts 'All dinosaurs in cretaceous period:'
dex.in_period('cretaceous').print
puts 'All large dinosaurs:'
dex.above_weight(2000).print
puts 'All small Dinosaurs (includes dinosaurs without weight):'
dex.below_weight(1000).print
puts 'Chaining example'
dex.walking('Biped').carnivores.print

puts 'Print specific dinosaur information'
puts dex.at_index(2)
