require_relative '../dinosaur_catalog.rb'

describe DinosaurCatalog do
  fooasaurus = {
    name: "Fooasaurus",
    period: "Late Fooeous",
    continent: "North Amerifoo",
    diet: "Carnivore",
    weight_in_lbs: "5000",
    walking: "Fooped",
    description: "Like a Foo-Rex but smaller.",
    weight: "5000",
  }

  barosaurus = {
    genus: "Barosaurus",
    period: "Barassic",
    carnivore: "No",
    weight: "4000",
    walking: "Biped",
    name: "Barosaurus",
  }

  context "When creating a new DinosaurCatalog with CSV files" do
    before(:each) do
      allow(File).to receive(:open).and_return(
        StringIO.new(
          "NAME,PERIOD,CONTINENT,DIET,WEIGHT_IN_LBS,WALKING,DESCRIPTION\n"\
          "Fooasaurus,Late Fooeous,North Amerifoo,Carnivore,5000,Fooped,"\
            "Like a Foo-Rex but smaller."
        ),
        StringIO.new(
          "Genus,Period,Carnivore,Weight,Walking\n"\
          "Barosaurus,Barassic,No,4000,Biped"
        ),
      )

      @dinocat = DinosaurCatalog.new(csv_files: [
        "foo.csv",
        "bar.csv",
      ])
    end

    describe "#new" do
      it "sets a default json_file_name" do
        expect(@dinocat.json_file_name).to eq "dinodex.json"
      end
    end

    describe "#dinosaur_catalog_periods" do
      it "returns a list of dinosaur time periods" do
        expect(@dinocat.dinosaur_catalog_periods).to eq [
          "Late Fooeous",
          "Barassic",
        ]
      end
    end

    describe "#find_large" do
      it "returns a list of dinosaurs over 2 tons" do
        expect(@dinocat.find_large).to eq [fooasaurus]
      end
    end

    describe "#find_small" do
      it "returns a list of dinosaurs <= 2 tons" do
        expect(@dinocat.find_small).to eq [barosaurus]
      end
    end

    describe "#find_bipeds" do
      it "returns a list of only bipeds" do
        expect(@dinocat.find_bipeds).to eq [barosaurus]
      end
    end

    describe "#find_carnivores" do
      it "returns a list of only carnivores" do
        expect(@dinocat.find_carnivores).to eq [fooasaurus]
      end
    end

    describe "#find_by_period" do
      it "returns a list of dinos by period" do
        expect(@dinocat.find_by_period("late fooeous")).to eq [fooasaurus]
      end
    end

    describe "#find_dinos" do
      it "performs a case insensitive search" do
        expect(@dinocat.find_dinos(:walking, "BIPED")).to eq [barosaurus]
      end
    end
  end
end
