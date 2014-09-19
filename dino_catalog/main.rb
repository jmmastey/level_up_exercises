require_relative "dinodex"

dinodex = DinoDex.new()
dinodex.add_data("dinodex.csv", "african_dinosaur_export.csv")

bipeds = dinodex.find(walking: "Biped")
puts "Bipeds:"
puts bipeds

# Does not meet definition today
carnivores = dinodex.find(diet: "Carnivore")
puts carnivores

cretaceous = dinodex.find(period: "Cretaceous")
puts cretaceous

big = dinodex.find(weight: [">", 4000])
puts big

small = dinodex.find(weight: ["<=", 4000])
puts small

small2 = dinodex.having_weight(["<=", 4000])
puts small2

combined = dinodex.find(carnivore: true,
                        walking: "Biped")
puts combined

chained = dinodex.find(carnivore: true).find(walking: "Biped")
puts chained

having_chaind = dinodex
  .having_carnivore(true)
  .having_walking("Biped")
puts having_chaind

puts having_chaind.first

puts
puts "JSON:"
puts dinodex.to_json
