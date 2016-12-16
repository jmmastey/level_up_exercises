require_relative "../dino_csv_parser"
SPEC_ROOT = File.expand_path("..", __FILE__)

describe DinoCsvParser do

  let(:sample_output) { 
    DinoCsvParser.from_csv_directory(SPEC_ROOT+"/test")
  }
  let(:sample_from_dinodex_format) {
    DinoCsvParser.from_csv_file(SPEC_ROOT+"/test/dinodex_format.csv")
  }
  let(:sample_from_african_dinosaur_format) {
    DinoCsvParser.from_csv_file(SPEC_ROOT+"/test/african_dino_format.csv")
  }


  describe ".from_csv_directory" do
  #   it "should call 'bar' with appropriate arguments" do
  # expect(subject).to receive(:bar).with("an argument I want")
  # subject.foo
  #   end



    it "pulls from 'dino_catalog/dino_fact_csv' if no other directory is provided"do
      sbj = DinoCsvParser.from_csv_directory
      expect(sbj.count).to eq(17)
      expect(sbj.first).to eq({
        :name=>"Abrictosaurus", 
        :period=>"Jurassic", 
        :diet=>"herbivore", 
        :weight=>100, 
        :locomotion=>"Biped"
      })
      expect(sbj.last).to eq({
        :name=>"Dracopelta", 
        :period=>"Early Cretaceous or Late Jurassic", 
        :diet=>"Herbivore", 
        :weight=>nil, 
        :locomotion=>"Quadruped",
        :additional_info=>{
          "continent"=>"South America", 
          "description"=>"One of the most primitive known Ankylosauria."
        }
      })
    end

    it "returns hashes of csv data in provided directory" do
      expect(sample_output.count).to eq(10)
      expect(sample_output.first).to eq({
        :name=>"Albertosaurus", 
        :period=>"Late Cretaceous",  
        :diet=>"Carnivore", 
        :weight=>2000, 
        :locomotion=>"Biped",
        :additional_info=>{
          "continent"=>"North America", 
          "description"=>"Like a T-Rex but smaller."
        }
      })
      expect(sample_output.last).to eq({
        :name=>"Suchomimus", 
        :period=>"Cretaceous", 
        :diet=>"carnivore", 
        :weight=>10400, 
        :locomotion=>"Biped"
      })
    end
  end

  describe ".from_csv_file" do
    it "returns the csv data in argument hashes for a dinosaur" do
      subject = DinoCsvParser.from_csv_file(SPEC_ROOT+"/test/dinodex_format.csv")
      expect(subject.count).to eq(5)
      expect(subject.first).to eq({
        :name=>"Albertosaurus", 
        :period=>"Late Cretaceous", 
        :diet=>"Carnivore", 
        :weight=>2000, 
        :locomotion=>"Biped",
        :additional_info=>{
          "continent"=>"North America", 
          "description"=>"Like a T-Rex but smaller."
        } 
      })
      expect(subject.last).to eq({
        :name=>"Diplocaulus", 
        :period=>"Late Permian",  
        :diet=>"Carnivore", 
        :weight=>nil, 
        :locomotion=>"Quadruped",
        :additional_info=>{
          "continent"=>"North America", 
          "description"=>"They actually had fins on the side of their body."
        }        
      })
    end
  end

  describe "canonize data" do
    it "adds recognized column data to arg" do
      expect(sample_from_dinodex_format.first[:name]).to eq("Albertosaurus")
      expect(sample_from_african_dinosaur_format.first[:name]).to eq("Abrictosaurus")
    end
    it "adds recognized special case data to arg" do
      expect(sample_from_african_dinosaur_format.first[:diet]).to eq("herbivore")
      expect(sample_from_african_dinosaur_format.last[:diet]).to eq("carnivore")
    end
    it "adds unrecognized cases to an additional info hash" do
      expect(sample_from_dinodex_format.first[:additional_info]).to eq({
        "continent"=>"North America", 
        "description"=>"Like a T-Rex but smaller."
      })
      expect(sample_from_african_dinosaur_format.first[:additional_info]).to be_nil
    end
  end
end