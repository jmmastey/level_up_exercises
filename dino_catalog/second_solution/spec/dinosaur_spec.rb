require_relative "../dinosaur"
require 'csv'

describe Dinosaur do

  let(:bob) { Dinosaur.new({name: "Bob", 
                            weight: 280, 
                            diet: "coffee & doughnuts", 
                            locomotion: "rolling chair", 
                            period: "haven't gone since highschool", 
                            additional_info: {fun_fact: "I only drink when I smoke", 
                                              best_quote: "there aint no sunshine when shes gone"
                                              }
                            })
            }

  let(:african_herbivore_csv_row) { CSV::Row.new ['genus','period','carnivore','weight','walking'], ['Abrictosaurus','Jurassic','No',100,'Biped']}
  let(:african_carnivore_csv_row){ CSV::Row.new ['genus','period','carnivore','weight','walking'], ['Suchomimus','Cretaceous','Yes',10400,'Biped']}
  let(:dex_insectivore_csv_row){ CSV::Row.new ['name','period','continent','diet','walking','description'], ['Albertonykus','Early Cretaceous','North America','Insectivore','Biped','Earliest known Alvarezsaurid.']}
  let(:dex_carnivore_csv_row){ CSV::Row.new ['name','period','continent','diet','weight_in_lbs','walking','description'],['Albertosaurus','Late Cretaceous','North America','Carnivore',2000,'Biped','Like a T-Rex but smaller.']}
  let(:dex_piscivore_csv_row){CSV::Row.new ['name','period','continent','diet','weight_in_lbs','walking','description'], ["Baryonyx", "Early Cretaceous","Europe","Piscivore",6000,"Biped","One of the only known dinosaurs with a fish-only diet."]}
  let(:dex_herbivore_csv_row){CSV::Row.new ['name','period','continent','diet','walking','description'], ["Dracopelta","Early Cretaceous or Late Jurassic","South America","Herbivore","Quadruped","One of the most primitive known Ankylosauria"]}


  let(:african_herbivore_args) {Dinosaur.construct_args_from_csv(african_herbivore_csv_row)}
  let(:african_carnivore_args) {Dinosaur.construct_args_from_csv(african_carnivore_csv_row)}
  let(:dex_insectivore_args) {Dinosaur.construct_args_from_csv(dex_insectivore_csv_row)}
  let(:dex_carnivore_args) {Dinosaur.construct_args_from_csv(dex_carnivore_csv_row)}
  let(:dex_piscivore_args) {Dinosaur.construct_args_from_csv(dex_piscivore_csv_row)}
  let(:dex_herbivore_args) {Dinosaur.construct_args_from_csv(dex_herbivore_csv_row)}


  let(:african_herbivore_dino) {Dinosaur.from_csv_row(african_herbivore_csv_row)}
  let(:african_carnivore_dino) {Dinosaur.from_csv_row(african_carnivore_csv_row)}
  let(:dex_insectivore_dino) {Dinosaur.from_csv_row(dex_insectivore_csv_row)}
  let(:dex_carnivore_dino) {Dinosaur.from_csv_row(dex_carnivore_csv_row)}
  let(:dex_piscivore_dino) {Dinosaur.from_csv_row(dex_piscivore_csv_row)}
  let(:dex_herbivore_dino) {Dinosaur.from_csv_row(dex_herbivore_csv_row)}


  describe "#initialize and accesors" do
    it "creates a dinosaur object" do
      expect(bob).to be_an_instance_of Dinosaur
    end
    it "has a #name" do
      expect(bob.name).to eq("Bob")
    end
    it "has a #weight" do
      expect(bob.weight).to eq(280)
    end
    it "has a #diet" do
      expect(bob.diet).to eq("coffee & doughnuts")
    end
    it "has a #locomotion" do
      expect(bob.locomotion).to eq("rolling chair")
    end
    it "has a #period" do
      expect(bob.period).to eq("haven't gone since highschool")
    end
    it "populates an #additional_info hash" do
      expect(bob.additional_info).to be_an_instance_of Hash
      expect(bob.additional_info[:fun_fact]).to eq("I only drink when I smoke")
      expect(bob.additional_info[:best_quote]).to eq("there aint no sunshine when shes gone")
    end
  end

  describe "#big?" do
    it "responds true if weight is >= 4000" do
      expect(african_carnivore_dino.big?).to be true
    end
    it "responds false if weight is < 4000" do
      expect(dex_carnivore_dino.big?).to be false
    end
  end

  describe "#carnivore?" do
    it "responds true if diet is 'carnivore'" do
      expect(dex_carnivore_dino.carnivore?).to be true
    end
    it "responds true if diet is 'insectivore'" do
      expect(dex_insectivore_dino.carnivore?).to be true
    end
    it "responds true if diet is 'piscivore'" do
      expect(dex_piscivore_dino.carnivore?).to be true
    end
    it "responds false if diet is 'herbivore'" do
      expect(dex_herbivore_dino.carnivore?).to be false
    end
  end

  describe "#biped?" do
    it "responds true if locomotion is =='biped'" do
      expect(dex_piscivore_dino.biped?).to be true
    end
    it "responds false if locomotion is !='biped'" do
      expect(dex_herbivore_dino.biped?).to be false
    end
  end

  describe "#from?(age)" do
    it "responds true if passed age == model.period" do
      expect(dex_carnivore_dino.from?("Cretaceous")).to be true
    end
    it "responds true even if model.period includes additional words" do
      expect(dex_insectivore_dino.from?("Cretaceous")).to be true
    end
    it "responds false if passed age != model.period" do
      expect(dex_carnivore_dino.from?("Jurassic")).to be false
    end
  end

  describe "#attribute_value?(attribute, value)" do
    it "responds true if model.attribute == value" do
      expect(african_herbivore_dino.attribute_value?("name", "Abrictosaurus")).to be true
    end
    it "responds false if model.attribute != value" do
      expect(african_herbivore_dino.attribute_value?("name", "Bob")).to be false
    end
    it "responds false if model.attribute unassigned" do
      expect(dex_insectivore_dino.attribute_value?("weight", 100)).to be false
    end
  end

  describe "#additional_info_value?(additional_info_catagory, additional_info_value)" do
    it "responds true if the additional_info attribute has k-v matching passed vars" do
      expect(dex_herbivore_dino.additional_info_value?("continent", "South America")).to be true
    end
    it "responds false if the additional_info doesn't have matching value" do
      expect(dex_herbivore_dino.additional_info_value?("continent", "Europe")).to be false
    end
    it "responds false if the additional_info doesn't have matching value" do
      expect(dex_herbivore_dino.additional_info_value?("time", "now")).to be false
    end
    it "responds false if it doesn't have an additional_info attribute" do
      expect(african_herbivore_dino.additional_info_value?("continent", "Europe")).to be false
    end
  end

  describe "#to_h" do
    it "produces a hash" do
      expect(african_herbivore_dino.to_h).to be_an_instance_of Hash
    end
    it "has all the model's attributes" do
      expect(african_herbivore_dino.to_h["name"]).to eq("Abrictosaurus")
      expect(african_herbivore_dino.to_h["weight"]).to eq(100)
      expect(african_herbivore_dino.to_h["diet"]).to eq("herbivore")
      expect(african_herbivore_dino.to_h["period"]).to eq("Jurassic")
      expect(african_herbivore_dino.to_h["locomotion"]).to eq("Biped")
    end
  end

  describe "#to_s" do
    it "should output a formated string with the models data" do
      expect(african_carnivore_dino.to_s).to eq("name: Suchomimus, weight: 10400, diet: carnivore, locomotion: Biped, period: Cretaceous\n\n")
    end
  end



############  class method tests  ###################

  describe ".from_csv_row" do
    it "returns a fully populated dinosaur obj" do
      expect(african_herbivore_dino).to be_an_instance_of Dinosaur
      expect(dex_insectivore_dino).to be_an_instance_of Dinosaur
      expect(african_herbivore_dino.name).to eq("Abrictosaurus")
      expect(african_herbivore_dino.weight).to eq(100)
      expect(dex_carnivore_dino.weight).to eq(2000)
      expect(african_herbivore_dino.diet).to eq("herbivore")
      expect(african_carnivore_dino.diet).to eq("carnivore")      
      expect(african_herbivore_dino.locomotion).to eq("Biped")
      expect(african_herbivore_dino.period).to eq("Jurassic")
      expect(dex_insectivore_dino.additional_info).to eq({"continent"=>"North America", "description"=>"Earliest known Alvarezsaurid."})
    end
  end

  describe ".construct_args_from_csv" do
    it "returns an arguments hash" do      
      expect(african_herbivore_args).to be_an_instance_of Hash
      expect(dex_insectivore_args).to be_an_instance_of Hash
    end
    it "processes RECOGNIZED_CSV_COLUMN_HEADERS" do
      expect(african_herbivore_args[:name]).to eq("Abrictosaurus")
      expect(african_herbivore_args[:weight]).to eq(100)
      expect(dex_carnivore_args[:weight]).to eq(2000)
      expect(african_herbivore_args[:locomotion]).to eq("Biped")
      expect(african_herbivore_args[:period]).to eq("Jurassic")
    end
    it "process SPECIAL_CASE_CSV_COLUMN_HEADERS" do
      expect(african_herbivore_args[:diet]).to eq("herbivore")
      expect(african_carnivore_args[:diet]).to eq("carnivore") 
    end
    it "processes unrecognized column headers" do
      expect(dex_insectivore_args[:additional_info]).to eq({"continent"=>"North America", "description"=>"Earliest known Alvarezsaurid."})    
    end
  end

  describe ".attribute_from_recognized_csv_header" do
    it "returns symbol of model attribute name for given csv header" do
      expect(Dinosaur.attribute_from_recognized_csv_header("name")).to eq(:name)
      expect(Dinosaur.attribute_from_recognized_csv_header("genus")).to eq(:name)
      expect(Dinosaur.attribute_from_recognized_csv_header("weight")).to eq(:weight)
      expect(Dinosaur.attribute_from_recognized_csv_header("weight_in_lbs")).to eq(:weight)
      expect(Dinosaur.attribute_from_recognized_csv_header("locomotion")).to eq(:locomotion)
      expect(Dinosaur.attribute_from_recognized_csv_header("walking")).to eq(:locomotion)
      expect(Dinosaur.attribute_from_recognized_csv_header("period")).to eq(:period)
      expect(Dinosaur.attribute_from_recognized_csv_header("diet")).to eq(:diet)
    end
  end

  describe ".add_recognized_data_to_arg" do
    it "adds k-v pair to arg hash, where k is model attribute name" do
      name = {old_data: "test"}
      Dinosaur.add_recognized_data_to_arg("name", "Bob", name)
      expect(name).to eq({name: "Bob", old_data: "test"})

      genus = {old_data: "test"}
      Dinosaur.add_recognized_data_to_arg("genus", "Jan", genus)
      expect(genus).to eq({name: "Jan", old_data: "test"})

      weight = {old_data: "test"}
      Dinosaur.add_recognized_data_to_arg("weight", 200, weight)
      expect(weight).to eq({weight: 200, old_data: "test"})

      weight_in_lbs = {old_data: "test"}
      Dinosaur.add_recognized_data_to_arg("weight_in_lbs", 100, weight_in_lbs)
      expect(weight_in_lbs).to eq({weight: 100, old_data: "test"})

      locomotion = {old_data: "test"}
      Dinosaur.add_recognized_data_to_arg("locomotion", "biped", locomotion)
      expect(locomotion).to eq(locomotion: "biped", old_data: "test")

      walking = {old_data: "test"}
      Dinosaur.add_recognized_data_to_arg("walking", "four legs", walking)
      expect(walking).to eq({locomotion: "four legs", old_data: "test"})
      
      period = {old_data: "test"}
      Dinosaur.add_recognized_data_to_arg("period", "first after lunch", period)
      expect(period).to eq({period: "first after lunch", old_data: "test"})
      
      diet = {old_data: "test"}
      Dinosaur.add_recognized_data_to_arg("diet", "whatever is cooking", diet)
      expect(diet).to eq({diet: "whatever is cooking", old_data: "test"})
    end
  end

  describe ".add_special_case_data_to_arg" do
    it "adds k-v pair to arg hash, where k is model attribute name" do
      carnivore = {old_data: "test"}
      Dinosaur.add_special_case_data_to_arg("carnivore", "Yes", carnivore)
      expect(carnivore).to eq({diet: "carnivore", old_data: "test"})

      herbivore = {old_data: "test"}
      Dinosaur.add_special_case_data_to_arg("carnivore", "No", herbivore)
      expect(herbivore).to eq({diet: "herbivore", old_data: "test"})
    end
  end

  describe ".special_case_carnivore_data" do
    it "returns 'carnivore' if 'yes'" do
      expect(Dinosaur.special_case_carnivore_data("Yes")).to eq("carnivore")
    end
    it "returns 'herbivore' if 'no'" do
      expect(Dinosaur.special_case_carnivore_data("No")).to eq("herbivore")
    end
  end

  describe ".add_unrecognized_data_to_arg" do
    it "adds k-v pair to existing additional_info attribute" do
      data_set = {old_data: "test"}
      Dinosaur.add_unrecognized_data_to_arg("continent", "North America", data_set)
      expect(data_set).to eq({old_data: "test", additional_info: {"continent" => "North America"}})
    end

    it "adds additional_info hash to model with k-v pair" do
      additional_info = {old_data: "test", additional_info: {"description"=>"Earliest known Alvarezsaurid."}}
      Dinosaur.add_unrecognized_data_to_arg("continent", "North America", additional_info)
      expect(additional_info).to eq({old_data: "test", additional_info: {"continent" => "North America", "description"=>"Earliest known Alvarezsaurid."}})
    end
  end
end