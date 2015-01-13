require './spec/spec_helper.rb'

describe DinoDex do

  let(:dino_dex) { DinoDex.new }

  describe "#initialize" do
    it "initializes the object" do
      expect(dino_dex).to be_a(DinoDex)
    end

    it "calls #parse_csv upon initialization" do
      dino_dex = DinoDex.allocate
      expect(dino_dex).to receive(:parse_csv)
      dino_dex.send(:initialize)
    end
  end

  describe "#search" do
    context "when searching for ambulation" do
      ['biped', 'quadruped'].each do |ambulation|
        it "returns all dinosaurs that are #{ambulation}" do
          dinos = dino_dex.search(:ambulation => ambulation)
          expect(dinos.detect { |d| d[:ambulation] == ambulation } ).to_not be_nil
        end
      end
    end

    context "when searching for diet" do
      ['carnivore', 'non-carnivore', 'piscivore', 'insectivore'].each do |diet|
        it "returns all dinosaurs that are #{diet}" do
          dinos = dino_dex.search(:diet => diet)
          expect(dinos.detect { |d| d[:diet] == diet } ).to_not be_nil
        end
      end
    end

    context "when searching for periods" do
      ['late cretaceous', 'early cretaceous', 'late permian', 'jurassic', 'oxfordian', 'albian', 'cretaceous', 'triassic'].each do |period|
        it "returns a dinosaur from the #{period} period" do
          dinos = dino_dex.search(:period => period)
          expect(dinos.detect { |d| d[:period] == period } ).to_not be_nil
        end
      end
    end

    context "when searching for a dinosaurs weight" do
      it "returns dinosaurs with weight greater than amount" do
        dinos = dino_dex.search(:weight => '+100000')
        expect(dinos.detect { |d| d[:weight] > 100000 } ).to_not be_nil
      end
      it "returns dinosaurs with weight less than amount" do
        dinos = dino_dex.search(:weight => '-100000')
        expect(dinos.detect { |d| d[:weight] < 100000 } ).to_not be_nil
      end
      context "when searching for a dinosaur weight equal to maount" do
        it "when it yields a result it is not nil" do
          dinos = dino_dex.search(:weight => '10400')
          expect(dinos.detect { |d| d[:weight] == 10400 } ).to_not be_nil
        end
        it "when it does not yield a result it returns nil" do
          dinos = dino_dex.search(:weight => '23434')
          expect(dinos.detect { |d| d[:weight] == 23434 } ).to be_nil
        end
      end
    end
  end

  describe "#export_to_json" do
    context "when :dinosaurs is empty" do
      it "raises an error" do
        dino_dex.dinosaurs = {}
        expect{dino_dex.export_to_json}.to raise_error
      end
    end
    context "when :dinosaurs is not empty" do
      it "outputs a json format of the :dinosaurs hash" do
        expect(JSON.parse(dino_dex.export_to_json)).to_not be_empty
      end
    end
  end
end
