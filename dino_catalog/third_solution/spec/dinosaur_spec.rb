require_relative "../dinosaur"

describe Dinosaur do
  let(:subject_bob){
    Dinosaur.new({
      name: "Bob", 
      weight: 280, 
      diet: "coffee & doughnuts", 
      locomotion: "rolling chair", 
      period: "haven't gone since highschool", 
      additional_info: {
        "fun fact"   => "I only drink when I smoke", 
        "best quote" => "there aint no sunshine when shes gone"
      }
    })
  }

  let(:subject_big){
    Dinosaur.new({ weight: 4000})
  }
  let(:subject_not_big){
    Dinosaur.new({ weight: 3999})
  }
  let(:subject_herbivore){
    Dinosaur.new({ diet: "herbivore"})
  }
  let(:subject_carnivore){
    Dinosaur.new({ diet: "carnivore"})
  }
  let(:subject_piscivore){
    Dinosaur.new({ diet: "piscivore"})
  }
  let(:subject_insectivore){
    Dinosaur.new({ diet: "insectivore"})
  }
  let(:subject_biped){
    Dinosaur.new({ locomotion: "biped"})
  }
  let(:subject_quadraped){
    Dinosaur.new({ locomotion: "quadruped"})
  }
  let(:subject_period){
    Dinosaur.new({period: "Jurassic"})
  }
  let(:subject_period_multi){
    Dinosaur.new({period: "Early Cretaceous or Late Jurassic"})
  }

  describe "#initialize and accesors" do
    it "#name" do
      expect(subject_bob.name).to eq("Bob")
    end
    it "#weight" do
      expect(subject_bob.weight).to eq(280)
    end
    it "#diet" do
      expect(subject_bob.diet).to eq("coffee & doughnuts")
    end
    it "#locomotion" do
      expect(subject_bob.locomotion).to eq("rolling chair")
    end
    it "#period" do
      expect(subject_bob.period).to eq("haven't gone since highschool")
    end
    it "#additional_info" do
      expect(subject_bob.additional_info["fun fact"]).to eq("I only drink when I smoke")
      expect(subject_bob.additional_info["best quote"]).to eq("there aint no sunshine when shes gone")
    end
  end

  describe "#big?" do
    it "is true for dino >= 4000" do
      expect(subject_big.big?).to be true
    end
    it "is false for dino < 4000" do
      expect(subject_not_big.big?).to be false
    end
  end

  describe "#carnivore?" do
    it "is true for carnivores, piscivores, and insectivores" do
      expect(subject_carnivore.carnivore?).to be true
      expect(subject_piscivore.carnivore?).to be true
      expect(subject_insectivore.carnivore?).to be true
    end
    it "is fase for herbivores" do
      expect(subject_herbivore.carnivore?).to be false
    end
  end

  describe "#biped?" do
    it "is true for bipeds" do
      expect(subject_biped.biped?).to be true
    end
    it "is false for quadrapeds" do
      expect(subject_quadraped.biped?).to be false
    end
  end

  describe "#from?(age)"do
    it "is true when age is part of dino's period" do
      expect(subject_period.from?("jurassic")).to be true
      expect(subject_period.from?("Jurassic")).to be true
      expect(subject_period_multi.from?("jurassic")).to be true
      expect(subject_period_multi.from?("cretaceous")).to be true
    end
    it "is false when age passed isn't part of dino's period" do
      expect(subject_period.from?("modern")).to be false
    end
  end

  describe "#attribute_value?(attribute, value)" do
    it "is true when dino has that attrib w/ that value" do
      expect(subject_bob.attribute_value?("name", "Bob")).to be true
    end
    it "is false when dino doesn't have atrib or value" do
      expect(subject_big.attribute_value?("name", "whatever")).to be false
      expect(subject_bob.attribute_value?("name", "steve")).to be false
    end
  end

  describe "#additional_info_value?(key, value)" do
    it "is false when dino doesn't have additional info" do
      expect(subject_big.additional_info_value?("anything", "whatever")).to be false
    end
    it "is false when dino doesn't have key in additional_info" do
      expect(subject_bob.additional_info_value?("invalid key", "anything")).to be false
    end
    it "is false when dino doesn't have value matching the key" do
      expect(subject_bob.additional_info_value?("best quote", "wrong quote")).to be false
    end
    it "is true when key & value match with dino" do
      expect(subject_bob.additional_info_value?("best quote", "there aint no sunshine when shes gone")).to be true
      expect(subject_bob.additional_info_value?("BEST Quote", "there aint no sunshine when shes gone")).to be true
      expect(subject_bob.additional_info_value?("best quote", "THERE AINT NO SUNSHINE WHEN SHES GONE")).to be true
    end
  end

  describe "#to_s" do
    it "has all attributes of obj, including under additional_info" do
      expect(subject_bob.to_s).to eq("name: Bob, weight: 280, diet: coffee & doughnuts, locomotion: rolling chair, period: haven't gone since highschool, fun fact: I only drink when I smoke, best quote: there aint no sunshine when shes gone\n\n")
    end
    it "skips values not completed for model" do
      expect(subject_big.to_s).to eq("weight: 4000\n\n")
    end
  end

  describe "#to_h" do
    it "has all attributes of obj" do
      expect(subject_bob.to_h).to eq({"name"=>"Bob", "weight"=>280, "diet"=>"coffee & doughnuts", "locomotion"=>"rolling chair", "period"=>"haven't gone since highschool", "additional_info"=>{"fun fact"=>"I only drink when I smoke", "best quote"=>"there aint no sunshine when shes gone"}})
    end
    it "skips attributes no completed for model" do
      expect(subject_big.to_h).to eq({"weight" => 4000})
    end
  end

end