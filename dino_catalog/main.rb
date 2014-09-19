require_relative "dinodex"

dinodex = DinoDex.new()
dinodex.add_data("dinodex.csv", "african_dinosaur_export.csv")

bipeds = dinodex.filter(walking: "Biped")
puts "Bipeds:"
puts bipeds

# Does not meet definition today
carnivores = dinodex.filter(diet: "Carnivore")
puts carnivores

cretaceous = dinodex.filter(period: "Cretaceous")
puts cretaceous

big = dinodex.filter(weight: [">", 4000])
puts big

small = dinodex.filter(weight: ["<=", 4000])
puts small

small2 = dinodex.having_weight(["<=", 4000])
puts small2

combined = dinodex.filter(carnivore: true,
                        walking: "Biped")
puts combined

chained = dinodex.filter(carnivore: true).filter(walking: "Biped")
puts chained

having_chaind = dinodex
  .having_carnivore(true)
  .having_walking("Biped")
puts having_chaind

puts having_chaind.first

puts
puts "JSON:"
puts dinodex.to_json
