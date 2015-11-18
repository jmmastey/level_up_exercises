require_relative '../../lib/dino_catalog'

describe 'DinoCatalog::Dinodex' do
  before :each do
    @dino_collection = DinoCatalog::DinoImporter.new
    @imported_dinosaurs = @dino_collection.import_from_csv('lib/dinodex.csv')
    @dinodex = DinoCatalog::Dinodex.new(@imported_dinosaurs)
  end

  describe '#carnivores' do
    it 'returns only carnivore Dinosaurs' do
      carnivores = @dinodex.carnivores
      carnivores.each do |dinosaur|
        expect(dinosaur.diet.downcase).to satisfy { "carnivore" || "insectivore" || "piscivore" }
      end
    end
  end

  describe '#bipeds' do
    it 'returns only biped Dinosaurs' do
      bipeds = @dinodex.bipeds
      bipeds.each do |dinosaur|
        expect(dinosaur.walking.downcase).to eq("biped")
      end
    end
  end

  describe '#filter_by_attribute' do
    it 'returns a collection of Dinosaur objects' do
      big_dinos = @dinodex.filter_by_attribute("size", "big")
      expect(big_dinos).to all(be_a DinoCatalog::Dinosaur)
    end
  end
end
