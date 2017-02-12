require_relative '../../lib/dino_catalog'

describe 'DinoCatalog::Dinodex' do
  before :each do
    @importer = DinoCatalog::DinoImporter.new('lib/dinodex.csv')
    @dinodex = DinoCatalog::Dinodex.new(@importer.dinosaur_list)
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
      bipeds = @dinodex.bipeds.dinosaurs
      bipeds.each do |dinosaur|
        expect(dinosaur.walking.downcase).to be_biped
      end
    end
  end

  describe '#filter' do
    it 'returns a collection of Dinosaur objects' do
      big_dinos = @dinodex.filter(attribute: "size", value: "big").dinosaurs
      expect(big_dinos).to all(be_a DinoCatalog::Dinosaur)
    end
  end
end
