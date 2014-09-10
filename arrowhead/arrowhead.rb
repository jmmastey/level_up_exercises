require "./arrowdb"

arrowhead = ArrowDb.find_arrowhead(region: :northern_plains, type: :bifurcated)

puts "You have a(n) '#{arrowhead}' arrowhead. Probably priceless."
