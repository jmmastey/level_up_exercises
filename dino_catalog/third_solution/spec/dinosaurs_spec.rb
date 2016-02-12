require_relative "../dinosaurs"

describe Dinosaurs do
  test_path = File.expand_path("..", __FILE__) + "/test"
  test_args = DinoCsvParser.from_csv_directory(test_path)
  
  sample_collection = [
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
    }), 
    Dinosaur.new({
      name: "Mary", 
      weight: 180, 
      diet: "salad", 
      locomotion: "exer-ball", 
      period: "who has the time", 
      additional_info: {
        "favorit movie"   => "Under the Tuscan Sun", 
        "best quote" => "will over reason"
      }
    }),
    Dinosaur.new({
      name: "Jake", 
      weight: 235, 
      diet: "cereal", 
      locomotion: "subway", 
      period: "between now and then", 
      additional_info: {
        "fashion"   => "anti-chic", 
        "best quote" => "How can a clam cram in a clean cream can?"
      }
    })
  ]

  let(:subject_from_files) { Dinosaurs.from_args(test_args)}
  let(:subject_from_sample) { Dinosaurs.new(sample_collection)}

  describe ".from_args" do
    it "returns a dinosaurs object" do
      expect(subject_from_files).to be_an_instance_of(Dinosaurs)
    end
    it "populates dinosaurs collection with dinosaur-es" do
      expect(subject_from_files.collection).to all(be_a(Dinosaur))
    end
  end

  describe "#instantiation and accessors" do
    it "can initialize w/ and empty collection" do
      expect(Dinosaurs.new.collection).to eq([])
    end
    it "can init w/ a passed in collection" do
      expect(
        Dinosaurs.new(sample_collection).collection
      ).to eq(
        sample_collection
      )
    end
  end

  describe "#big_dinosaurs" do
    it "returns a dinosaurs object" do
      expect(
        subject_from_files.big_dinosaurs
      ).to be_an_instance_of(Dinosaurs)
    end
    it "the new objs collection is populated by only #big? dinos"do
      expect(
        subject_from_files.big_dinosaurs.collection
      ).to all(
        satisfy(&:big?)
      )
    end
    it "captures the right number of cases" do
      expect(
        subject_from_files.big_dinosaurs.collection.count
      ).to eq(3)
    end
  end

  describe "#small_dinosaurs" do
    it "returns a dinosaurs object" do
      expect(
        subject_from_files.small_dinosaurs
      ).to be_an_instance_of(Dinosaurs)
    end
    it "the new objs collection is populated by only !#big? dinos"do
      expect(
        subject_from_files.small_dinosaurs.collection
      ).to all(
        satisfy{|d| !d.big?}
      )
    end
    it "captures the right number of cases" do
      expect(
        subject_from_files.small_dinosaurs.collection.count
      ).to eq(7)
    end
  end

  describe "#biped_dinosaurs" do
    it "returns a dinosaurs object" do
      expect(
        subject_from_files.biped_dinosaurs
      ).to be_an_instance_of(Dinosaurs)
    end
    it "the new objs collection is populated by only #biped? dinos"do
      expect(
        subject_from_files.biped_dinosaurs.collection
      ).to all(
        satisfy(&:biped?)
      )
    end
    it "captures the right number of cases" do
      expect(
        subject_from_files.biped_dinosaurs.collection.count
      ).to eq(8)
    end
  end

  describe "#carnivorus_dinosaurs" do
    it "returns a dinosaurs object" do
      expect(
        subject_from_files.carnivorus_dinosaurs
      ).to be_an_instance_of(Dinosaurs)
    end
    it "the new objs collection is populated by only #carnivore? dinos"do
      expect(
        subject_from_files.carnivorus_dinosaurs.collection
      ).to(all(
        satisfy(&:carnivore?)
      ))
    end
    it "captures the right number of cases" do
      expect(
        subject_from_files.carnivorus_dinosaurs.collection.count
      ).to eq(8)
    end
  end

  describe "#dinosaurs_from(age)" do
    it "returns a dinosaurs object" do
      expect(
        subject_from_files.dinosaurs_from("Jurassic")
      ).to be_an_instance_of(Dinosaurs)
    end
    it "the new objs collection is populated by only dinos from age"do
      expect(
        subject_from_files.dinosaurs_from("Jurassic").collection
      ).to all(
        satisfy{|dino| dino.from?("Jurassic")}
      )
    end
    it "captures the right number of cases" do
      expect(
        subject_from_files.dinosaurs_from("Jurassic").collection.count
      ).to eq(2)
    end
  end

  describe "#search({terms})" do  ##see notes in dinosaurs line 57
    it "returns a dinosaurs object" do
      expect(
        subject_from_files.search({
          "continent" => "north america",
          "diet" => "insectivore"
        })
      ).to be_an_instance_of(Dinosaurs)
    end
    it "the new objs collection is populated only by dinos matching all search criteria" do
      expect(
        subject_from_files.search({
          "continent" => "north america",
          "diet" => "insectivore"
        }).collection
      ).to all(satisfy do |dino| 
        dino.additional_info_value?("continent","north america") &&
        dino.attribute_value?("diet", "insectivore")
      end)
    end
    it "captures the right number of cases" do
      expect(
        subject_from_files.search({
          "continent" => "north america",
          "diet" => "insectivore"
        }).collection.count
      ).to eq(1)
    end
  end

  describe "#display" do
    it "sends collection formated to string to output stream" do
      expect{ 
        subject_from_sample.display 
      }.to output(
        "name: Bob, weight: 280, diet: coffee & doughnuts, locomotion: rolling chair, period: haven't gone since highschool, fun fact: I only drink when I smoke, best quote: there aint no sunshine when shes gone\n\nname: Mary, weight: 180, diet: salad, locomotion: exer-ball, period: who has the time, favorit movie: Under the Tuscan Sun, best quote: will over reason\n\nname: Jake, weight: 235, diet: cereal, locomotion: subway, period: between now and then, fashion: anti-chic, best quote: How can a clam cram in a clean cream can?\n\n"
      ).to_stdout
    end
  end

  describe "#export_json" do
    it "" do
      p subject_from_sample.export_json
    end
  end
end