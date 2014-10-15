require_relative "../dinosaur_parser.rb"

dinosaurs = DinosaurParser.parse("../african_dinosaur_export.csv")

dinosaurs.each do |dinosaur|
  puts "-" * 100
  dinosaur.display
end
