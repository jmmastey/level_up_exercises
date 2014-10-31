require_relative "../dinosaur_parser.rb"
require_relative "../dinosaur_catalog.rb"

dinosaurs_af = DinosaurParser.parse("../african_dinosaur_export.csv")
dinosaurs_ww= DinosaurParser.parse("../dinodex.csv")

catalog = DinosaurCatalog.new
catalog.add dinosaurs_af
catalog.add dinosaurs_ww

catalog.add_filter(:continent, "africa").save_json
