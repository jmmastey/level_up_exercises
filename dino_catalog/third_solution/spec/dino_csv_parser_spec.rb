require_relative "../dino_csv_parser"

describe DinoCsvParser do

  let(:sample_output) { DinoCsvParser.from_directory("spec/test")}


  describe ".from_directory" do
    it "it pulls from 'dino_catalog/dino_fact_csv' if no other directory is provided"do
      sbj = DinoCsvParser.from_directory
      expect(sbj.count).to eq(17)
      expect(sbj.first).to eq({"genus"=>"Abrictosaurus", "period"=>"Jurassic", "carnivore"=>"No", "weight"=>100, "walking"=>"Biped"})
      expect(sbj.last).to eq({"name"=>"Dracopelta", "period"=>"Early Cretaceous or Late Jurassic", "continent"=>"South America", "diet"=>"Herbivore", "weight_in_lbs"=>nil, "walking"=>"Quadruped", "description"=>"One of the most primitive known Ankylosauria."})
    end

    it "returns hashes of csv data in provided directory" do
      expect(sample_output.count).to eq(10)
      expect(sample_output.first).to eq({"name"=>"Albertosaurus", "period"=>"Late Cretaceous", "continent"=>"North America", "diet"=>"Carnivore", "weight_in_lbs"=>2000, "walking"=>"Biped", "description"=>"Like a T-Rex but smaller."})
      expect(sample_output.last).to eq({"genus"=>"Suchomimus", "period"=>"Cretaceous", "carnivore"=>"Yes", "weight"=>10400, "walking"=>"Biped"})
    end
  end
end