require_relative "dinodex"

dinodex = DinoDex.new
puts dinodex

dinodex.add_data("dinodex.csv", "african_dinosaur_export.csv")
puts dinodex

puts dinodex.filter(walking: "Biped")
puts dinodex.filter(diet: "Carnivore")
puts dinodex.filter(carnivore: true)
puts dinodex.filter(period: "Cretaceous")
puts dinodex.filter(weight: [">", 4000])
puts dinodex.filter(weight: ["<=", 4000])
puts dinodex.having_weight(["<=", 4000])
puts dinodex.filter(carnivore: true,
                    walking: "Biped")
puts dinodex
  .filter(carnivore: true)
  .filter(walking: "Biped")
puts dinodex
  .having_carnivore(true)
  .having_walking("Biped")

puts
puts "First Dino: "
puts dinodex.first
puts dinodex.first.to_json

puts
puts "JSON:"
puts dinodex.to_json
