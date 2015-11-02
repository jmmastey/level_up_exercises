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

    context "DinoDex has query capabilities" do
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

      it "Can fetch animal (small) size correctly" do
        dinodex_instance.seed
        dinodex_instance.fetch_small.each do |dino|
          expect(dino.weight_lbs).to be < 2000
        end
      end

      it "Can use the master fetch and return unique results (Set) based on all search params" do
        dinodex_instance.seed
        unique_values = dinodex_instance.master_fetch({param1: "fetch_biped",
                                                       param2: "fetch_big"})
        expect(unique_values).to be_a(Set)
      end

      it "Can use the master fetch and return the same results as a simple query" do
        dinodex_instance.seed
        small = dinodex_instance.fetch_small
        small_master = dinodex_instance.master_fetch({param1: "fetch_small"})

        expect(small_master.to_a.flatten.length).to eq(small.length)
      end

      it "Can use the master fetch and return the same results as a query that takes parameters" do
        dinodex_instance.seed
        period = dinodex_instance.fetch_period("Triassic")
        period_master = dinodex_instance.master_fetch({"Triassic" => "fetch_period"})

        expect(period_master.to_a.flatten.length).to eq(period.length)
      end
    end

    it "Displays information about a group" do
      dinodex_instance.seed
      small = dinodex_instance.fetch_small
result = <<-EOT
#######################
Here are my details!!
#######################
Name -> Deinonychus
Period -> Early Cretaceous
Continent -> North America
Diet -> Carnivore
Weight_lbs -> 150
Walking -> Biped
#######################
#######################
Here are my details!!
#######################
Name -> Quetzalcoatlus
Period -> Late Cretaceous
Continent -> North America
Diet -> Carnivore
Weight_lbs -> 440
Walking -> Quadruped
Description -> Largest known flying animal of all time.
#######################
#######################
Here are my details!!
#######################
Name -> Abrictosaurus
Period -> Jurassic
Weight_lbs -> 100
Walking -> Biped
#######################
EOT
      expect(dinodex_instance.display_group(small)).to eq(result)
    end
  end

  describe Dinosaur do
    it "Creates an instance of Dinosaur" do
      expect(dinosaur).to be_an_instance_of(Dinosaur)
    end

    it "Dinosaur knows how to display itself" do

# Use heredoc to see the result better. I need this indentation as it is.
result = <<-EOT
#######################
Here are my details!!
#######################
Name -> Dracopelta
Period -> Early Cretaceous or Late Jurassic
Continent -> South America
Diet -> Herbivore
Weight_lbs -> 0
Walking -> Quadruped
Description -> One of the most primitive known Ankylosauria.
#######################
EOT
      expect(dinosaur.display).to eq(result)
    end

  end
end
