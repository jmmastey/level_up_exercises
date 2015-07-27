require_relative 'dinodex'

dinodex = Dinodex.new
ARGV.each do |arg|
  dinodex.load_csv(arg)
end

puts "\nAll the bipeds:"
dinodex.print_search(walking: 'biped')

puts "\nAll the carnivores:"
dinodex.print_search(diet: 'carnivore')

puts "\nAll the dinosaurs from the cretaceous period:"
dinodex.print_search(period: 'cretaceous')

puts "\nAll the big dinosaurs:"
dinodex.print_search(big: true)

puts "\nAll the small dinosaurs:"
dinodex.print_search(small: true)
