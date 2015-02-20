load 'dinodex.rb'
load 'formatter.rb'

puts '1- Grab all the dinosaurs that were bipeds.'
puts '    search_by_walking(Biped).print'
puts '2- Grab all the dinosaurs that were carnivores.'
puts '    search_carnivores.print'
puts '3- Grab dinosaurs for specific periods.'
puts '    search_by_period(Cretaceous).print'
puts '4- Grab only big (> 2 tons) or small dinosaurs.'
puts '    search_big.print'
puts '    search_small.print'
puts '5- Combine Search examples:'
puts '    search_by_walking(Biped).search_carnivores.print'
puts '    search_by_walking(Biped).search_by_period(Cretaceous).print'
puts '    search_by_walking(Biped).search_big.print'
puts '6- print all'
puts '    print'
puts '7- Print dinosaurs properties'
puts '    search_by_name(Albertonykus).print'
puts '8- Print collection'
puts '    search_by_source(african_dinosaur_export).print'
puts '9- print json'
puts '    search_by_walking(Biped).print_json'
puts ''

dinos = Dinodex.new('dinodex.csv', 'african_dinosaur_export.csv')
query = gets.chomp
puts ''
input = query.gsub(/[(]/, ',').gsub(/[).]/, ' ').split(' ')

input.each do |q|
  if q.include? ','
    dinos.send q.split(',')[0], q.split(',')[1]
  else
    dinos.send q.to_s
  end
end
