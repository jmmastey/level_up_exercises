require_relative "../dinosaur"

# -parse csv file
# -collection should
#   grab all biped dinosaurs
#   garab all carnivores dinos
#   grab all dino from specific period
#   grab all big or small dinos (>2tons)
#   chain commands

# -print for dinos
# -print for collection

# chain generic search (hash param passed in)
# export json

# parse csv file :: a seperate class which returns a json object 

describe Dinosaur do
  let(:subject_bob){
    Dinosaur.new({
      name: "Bob", 
      weight: 280, 
      diet: "coffee & doughnuts", 
      locomotion: "rolling chair", 
      period: "haven't gone since highschool", 
      additional_info: {
        fun_fact: "I only drink when I smoke", 
        best_quote: "there aint no sunshine when shes gone"
      }
    })
  }

  let(:subject_big){}
  let(:subject_not_bit){}
  let(:subject_herbivore){}
  let(:subject_carnivore){}
  let(:subject_biped){}
  let(:subject_quadraped){}

  describe "#initialize and accesors" do
    it "#name" do
      expect(subject_bob.name).to eq("Bob")
    end
    it "#weight" do
      expect(subject_bob.weight).to eq(280)
    end
    it "#diet" do
      expect(subject_bob.weight).to eq("coffee & doughnuts")
    end
    it "#locomotion" do
      expect(subject_bob.locomotion).to eq("rolling chair")
    end
    it "#period" do
      expect(subject_bob.period).to eq("haven't gone since highschool")
    end
    it "#additional_info" do
      expect(subject_bob.additional_info[:fun_fact]).to eq("I only drink when I smoke")
      expect(subject_bob.additional_info[:best_quote]).to eq("there aint no sunshine when shes gone")
    end

  end

end