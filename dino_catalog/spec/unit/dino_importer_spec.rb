require_relative '../../lib/dino_catalog'
require 'csv'

describe 'DinoCatalog::DinoImporter' do
  before :each do
    @importer = DinoCatalog::DinoImporter.new('lib/dinodex.csv')
  end

  describe '#import_from_csv' do
    it 'returns a collection of Dinosaur objects' do
      @importer.import_from_csv('lib/dinodex.csv')
      expect(@importer.dinosaur_list).to all(be_a DinoCatalog::Dinosaur)
    end

  end
end
