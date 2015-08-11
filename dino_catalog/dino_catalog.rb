require 'json'
require_relative 'dinodex'

puts
puts "***********"
puts "* Dinodex *"
puts "***********"
puts

dex = Dinodex.new

dex.import("dinodex.csv")
dex.import("african_dinosaur_export.csv")

puts "---------------"
puts "  Query: All carnivores larger than 2,000 lbs"
puts
dex.filter(weight: 2000, op: ">")
  .filter(carnivore: true)
  .each do |dino|
  puts dino.to_s
  puts
end

puts "---------------"
puts "  Query: All Cretaceous bipeds"
puts
dex.filter(walking: "Biped")
  .filter(period: "Cretaceous", op: "include?")
  .each do |dino|
  puts dino.to_s
  puts
end

puts "---------------"
puts "  Query: All non-American dinosaurs ('they terk er jerbs!')"
puts
dex.filter(continent: "America", op: "include?", negate: true)
  .each do |dino|
  puts dino.to_s
  puts
end

puts "--------------"
puts "  Query: All \"Albert's\" as JSON"
puts
puts dex.filter(name: "Albert", op: "start_with?").to_json
puts

puts "--------------"
puts "  Query: All \"Albert's\" as JSON (pretty)"
puts
puts JSON.pretty_generate(dex.filter(name: "Albert", op: "start_with?").to_hash)
puts
