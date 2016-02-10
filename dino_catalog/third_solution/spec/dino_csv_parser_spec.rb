require_relative "../dino_csv_parser"

describe DinoCsvParser do

  let(:sample_output) { DinoCsvParser.from_csv_directory("spec/test")}


  describe ".from_csv_directory" do
  #   it "should call 'bar' with appropriate arguments" do
  # expect(subject).to receive(:bar).with("an argument I want")
  # subject.foo
  #   end



    it "pulls from 'dino_catalog/dino_fact_csv' if no other directory is provided"do
      sbj = DinoCsvParser.from_csv_directory
      expect(sbj.count).to eq(17)

      expect(sbj.first).to eq({:name=>"Abrictosaurus", :period=>"Jurassic", :diet=>"herbivore", :weight=>100, :locomotion=>"Biped"})
      expect(sbj.last).to eq({:name=>"Dracopelta", :period=>"Early Cretaceous or Late Jurassic", :additional_info=>{"continent"=>"South America", "description"=>"One of the most primitive known Ankylosauria."}, :diet=>"Herbivore", :weight=>nil, :locomotion=>"Quadruped"})
    end

    it "returns hashes of csv data in provided directory" do
      expect(sample_output.count).to eq(10)
      expect(sample_output.first).to eq({:name=>"Albertosaurus", :period=>"Late Cretaceous", :additional_info=>{"continent"=>"North America", "description"=>"Like a T-Rex but smaller."}, :diet=>"Carnivore", :weight=>2000, :locomotion=>"Biped"})
      expect(sample_output.last).to eq({:name=>"Suchomimus", :period=>"Cretaceous", :diet=>"carnivore", :weight=>10400, :locomotion=>"Biped"})
    end
  end

  describe ".from_csv_file" do
    it "returns the csv data in argument hashes for a dinosaur" do
      subject = DinoCsvParser.from_csv_file("spec/test/file_one.csv")
      expect(subject.count).to eq(5)
      expect(subject.first).to eq({:name=>"Albertosaurus", :period=>"Late Cretaceous", :additional_info=>{"continent"=>"North America", "description"=>"Like a T-Rex but smaller."}, :diet=>"Carnivore", :weight=>2000, :locomotion=>"Biped"})
      expect(subject.last).to eq( {:name=>"Diplocaulus", :period=>"Late Permian", :additional_info=>{"continent"=>"North America", "description"=>"They actually had fins on the side of their body."}, :diet=>"Carnivore", :weight=>nil, :locomotion=>"Quadruped"})
    end
  end
end