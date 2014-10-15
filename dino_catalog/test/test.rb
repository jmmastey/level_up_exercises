require_relative "../dinosaur_parser.rb"

dinosaurs = DinosaurParser.parse("../dinodex.csv")

dinosaurs.each do |dinosaur|
  puts "-" * 100
  dinosaur.display
end
