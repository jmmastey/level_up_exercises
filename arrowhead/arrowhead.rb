require "./arrowdb"

arrowhead = ArrowDb.find_arrowhead(region: :random, type: :bifurcated)

puts "You have a(n) '#{arrowhead}' arrowhead. Probably priceless."
