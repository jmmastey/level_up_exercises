require_relative "dinodex"

dinodex = DinoDex.new("dinodex.csv", "african_dinosaur_export.csv")
bipeds = dinodex.find(walking: "Biped")
puts "Bipeds: #{bipeds.size}"
bipeds.each { |dino| puts dino }
puts

# Does not meet definition today
carnivores = dinodex.find(diet: "Carnivore")
puts "Carnivores: #{carnivores.size}"
carnivores.each { |dino| puts dino }
puts

cretaceous = dinodex.find(period: "Cretaceous")
puts "Cretaceous: #{cretaceous.size}"
cretaceous.each { |dino| puts dino }
puts

big = dinodex.find(weight: lambda { |w| w.to_i > 4000})
puts "Big: #{big.size}"
big.each { |dino| puts dino }
puts

small = dinodex.find(weight: lambda { |w| w.to_i < 4000})
puts "Small: #{small.size}"
small.each { |dino| puts dino }
puts

combined = dinodex.find(diet: "Carnivore",
                        walking: "Biped")
puts "Combinde: #{combined.size}"
combined.each { |dino| puts dino }
puts
