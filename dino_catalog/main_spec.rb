require_relative('main')


describe "DinoDex Controller" do

  let(:dinodex_instance) { DinoDex.new({data_source_A: "csv_data/dinodex.csv",
                               data_source_B: "csv_data/african_dinosaur_export.csv"}) }

  let(:dinosaur) {Dinosaur.new({:name=>"Dracopelta",
                                :period=>"Early Cretaceous or Late Jurassic",
                                :continent=>"South America",
                                :diet=>"Herbivore",
                                :weight_lbs=>0,
                                :walking=>"Quadruped",
                                :description=>"One of the most primitive known Ankylosauria."})}
  describe DinoDex do
    it "dinodex_instance is an instance of a DinoDex" do
      expect(dinodex_instance).to be_an_instance_of(DinoDex)
    end

    context "Can parse and store data correctly" do
      it "There are no Dinosaurs stored in the dinodex_instance" do
        expect(dinodex_instance.all_dinosaurs.length).to eq(0)
      end

      describe "We seed our dinodex with data from the csv inputs" do
        it "all_dinosaurs is no longer empty" do
          dinodex_instance.seed
          expect(dinodex_instance.all_dinosaurs.length).to be > 0
        end

        it "Stores Dinosaur instances in the dinodex" do
          dinodex_instance.seed
          expect(dinodex_instance.all_dinosaurs[0]).to be_an_instance_of(Dinosaur)
        end
      end
    end

    context "DinoDex has queying capabilities" do
      it "Can fetch walking type correctly" do
        dinodex_instance.seed
        dinodex_instance.fetch_biped.each do |dino|
          expect(dino.walking).to eq("Biped")
        end
      end

      it "Can fetch diet preference correctly" do
        dinodex_instance.seed
        dinodex_instance.fetch_carnivore.each do |dino|
          expect(dino.diet).to satisfy {["Carnivore", "Insectivore", "Piscivore"].any?}
        end
      end

      it "Can fetch periods of time correctly" do
        dinodex_instance.seed
        dinodex_instance.fetch_period("Triassic").each do |dino|
          expect(dino.period).to eq("Triassic")
        end
      end

      it "Can fetch animal (big) size correctly" do
        dinodex_instance.seed
        dinodex_instance.fetch_big.each do |dino|
          expect(dino.weight_lbs).to be > 2000
        end
      end

      it "Can fetch animal (small) size correctly" do
        dinodex_instance.seed
        dinodex_instance.fetch_small.each do |dino|
          expect(dino.weight_lbs).to be < 2000
        end
      end

    end
  end

  describe Dinosaur do
    it "Creates an instance of Dinosaur" do
      expect(dinosaur).to be_an_instance_of(Dinosaur)
    end
  end
end
