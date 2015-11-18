require_relative '../../lib/dino_catalog'
require 'csv'

describe 'DinoCatalog::DinoImporter' do
  before :each do
    @dino_collection = DinoCatalog::DinoImporter.new
    @imported_dinosaurs = @dino_collection.import_from_csv('lib/dinodex.csv')
  end

  describe '#import_from_csv' do
    it 'returns a collection of Dinosaur objects' do
      expect(@imported_dinosaurs).to all(be_a DinoCatalog::Dinosaur)
    end

    it 'changes data format for pirate bay format'
  end
end
