require_relative "../dinosaur"

describe Dinosaur do
  # args = {name: "Bob", weight: 180, diet: "coffee & doughnuts", locomotion: "rolling chair", period: "haven't since highschool", additional_info: {fun_fact: "I only drink when I smoke", best_quote: "there aint no sunshine when shes gone"}}
  # let(:bob) { Dinosaur.new(args)}

  
#  let(:bob) { Dinosaur.new(args)}  
    before :each do
      @bob = Dinosaur.new({name: "Bob", weight: 180, diet: "coffee & doughnuts", locomotion: "rolling chair", period: "haven't since highschool", additional_info: {fun_fact: "I only drink when I smoke", best_quote: "there aint no sunshine when shes gone"}})
    end

  describe "#initialize" do
    it "has a #name" do
      expect(@bob.name).to eq.("Bob")
    end

    it "has a #weight" do
      expect(@bob.weight).to eq.(180)
    end

    it "has a #diet" do
      expect(@bob.diet).to eq.("coffee & doughnuts")
    end

    it "has a #locomotion" do
      expect(@bob.locomotion).to eq.("rolling chair")
    end

    it "has a #period" do
      expect(@bob.period).to eq.("haven't gone since highschool")
    end

    it "populates an #additional_info hash" do
      expect(@bob.additional_info[:fun_fact]).to eq.("I only drink when I smoke")
      expect(@bob.additional_info[:best_quote]).to eq.("there aint no sunshine when shes gone")
    end
  end

end
