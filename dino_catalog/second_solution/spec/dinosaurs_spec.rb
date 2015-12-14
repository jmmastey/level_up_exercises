require_relative "../dinosaurs"


SPEC_ROOT = File.expand_path("..", __FILE__)
TEST_DIR_PATH = SPEC_ROOT + "/test"

FORMAT_ONE_FILE_DATA = "NAME,PERIOD,CONTINENT,DIET,WEIGHT_IN_LBS,WALKING,DESCRIPTION\nAlbertosaurus,Late Cretaceous,North America,Carnivore,2000,Biped,Like a T-Rex but smaller.\nAlbertonykus,Early Cretaceous,North America,Insectivore,,Biped,Earliest known Alvarezsaurid.\nBaryonyx,Early Cretaceous,Europe,Piscivore,6000,Biped,One of the only known dinosaurs with a fish-only diet.\nDeinonychus,Early Cretaceous,North America,Carnivore,150,Biped,\nDiplocaulus,Late Permian,North America,Carnivore,,Quadruped,They actually had fins on the side of their body."

FORMAT_TWO_FILE_DATA = "Genus,Period,Carnivore,Weight,Walking\nAbrictosaurus,Jurassic,No,100,Biped\nAfrovenator,Jurassic,Yes,,Biped\nCarcharodontosaurus,Albian,Yes,3000,Biped\nParalititan,Cretaceous,No,120000,Quadruped\nSuchomimus,Cretaceous,Yes,10400,Biped"

def stage_csv_files
  Dir.mkdir(TEST_DIR_PATH) unless File.exists?(TEST_DIR_PATH)
  File.open("#{TEST_DIR_PATH}/file_one.csv", "w") { |file| file.write(FORMAT_ONE_FILE_DATA)}
  File.open("#{TEST_DIR_PATH}/file_two.csv", "w") { |file| file.write(FORMAT_TWO_FILE_DATA)}
  ["#{TEST_DIR_PATH}/file_one.csv", "#{TEST_DIR_PATH}/file_two.csv"]
end

def stage_csv_directory
  Dir.mkdir(TEST_DIR_PATH) unless File.exists?(TEST_DIR_PATH)
  File.open("#{TEST_DIR_PATH}/file_one.csv", "w") { |file| file.write(FORMAT_ONE_FILE_DATA)}
  File.open("#{TEST_DIR_PATH}/file_two.csv", "w") { |file| file.write(FORMAT_TWO_FILE_DATA)}
  TEST_DIR_PATH
end



describe Dinosaurs do

  let(:default_dex) { Dinosaurs.from_directory }
  let(:dir_dex) {Dinosaurs.from_directory(stage_csv_directory)}
  let(:file_dex) {Dinosaurs.from_files(stage_csv_files)}
  let(:dino_obj) {Dinosaur.from_csv_row(CSV::Row.new ['name','period','continent','diet','walking','description'], ['Albertonykus','Early Cretaceous','North America','Insectivore','Biped','Earliest known Alvarezsaurid.'])}


  describe ".from_directory" do
    it "creates Dinosaurs obj from default dir w/out arg" do
      expect(default_dex).to be_an_instance_of Dinosaurs
    end
    it "accepts an optional file path on instantiation" do
      expect(dir_dex).to be_an_instance_of Dinosaurs
    end
    it "reads multiple files when instantiating" do
      expect(dir_dex.collection.count).to eq(10)
    end
    it "populates #dinosaurs with Dinosaur objs" do
      expect(dir_dex.collection.all?{|d| d.class == Dinosaur}).to be true
    end
  end

  describe ".from_files" do
    it "returns a Dinosaurs obj" do
      expect(file_dex).to be_an_instance_of Dinosaurs
    end
    it "reads multiple files when instantiating" do
      expect(file_dex.collection.count).to eq(10)
    end
    it "populates #dinosaurs with Dinosaur objs" do
      expect(file_dex.collection.all?{|d| d.class == Dinosaur}).to be true
    end
  end

  describe "#initialize" do
    it "creates a Dinosaurs object" do
      expect(default_dex).to be_an_instance_of Dinosaurs
    end
    it "defaults with an empty #collection" do
      expect(Dinosaurs.new.collection.empty?).to be true
    end
    it "accepts collection of another Dinosaurs as opt arg" do
      expect(Dinosaurs.new( dir_dex.collection ).collection.count).to eq(10)
    end
  end

  describe "#big_dinosaurs" do
    it "returns a Dinosaurs obj" do
      expect(dir_dex.big_dinosaurs).to be_an_instance_of Dinosaurs      
    end
    it "all obj in rtn are Dinosaur#big?==true" do
      expect(dir_dex.big_dinosaurs.collection.all?(&:big?)).to be true
    end
  end

  describe "#carnivorus_dinosaurs" do
    it "returns a Dinosaurs obj" do
      expect(dir_dex.carnivorus_dinosaurs).to be_an_instance_of Dinosaurs      
    end
    it "all obj in rtn are Dinosaur#carnivore?==true" do
      expect(dir_dex.carnivorus_dinosaurs.collection.all?(&:carnivore?)).to be true
    end
  end

  describe "#biped_dinosaurs" do
    it "returns a Dinosaurs obj" do
      expect(dir_dex.biped_dinosaurs).to be_an_instance_of Dinosaurs      
    end
    it "all obj in rtn are Dinosaur#biped?==true" do
      expect(dir_dex.biped_dinosaurs.collection.all?(&:biped?)).to be true
    end
  end

  describe "#dinosaurs_from(<period>)" do
    it "returns a Dinosaurs obj" do
      expect(dir_dex.dinosaurs_from("Jurassic")).to be_an_instance_of Dinosaurs      
    end
    it "all obj in rtn are Dinosaur#from?(<period>)==true" do
      expect(dir_dex.dinosaurs_from("Jurassic").collection.all?{|d| d.from?("Jurassic")}).to be true
    end
  end

  describe "#filter_by(category, value)" do
    let(:dino_recog_col_name) { dir_dex.filter_by("name", "Albertonykus")}
    let(:dino_spc_col_carnivore) {dir_dex.filter_by("carnivore", "carnivore")}
    let(:dino_add_info_continent) { dir_dex.filter_by("continent", "America")}

    it "returns a Dinosaurs object" do
      expect(dino_recog_col_name).to be_an_instance_of Dinosaurs
      expect(dino_spc_col_carnivore).to be_an_instance_of Dinosaurs
      expect(dino_add_info_continent).to be_an_instance_of Dinosaurs    
    end
    it "returns matching dinos when recog csv col passed as category" do
      expect(dino_recog_col_name.collection.all?{|d| d.name == "Albertonykus"}).to be true
    end
    it "returns matching dinos when special csv col passed as category" do
      expect(dino_spc_col_carnivore.collection.all?(&:carnivore?)).to be true
    end
    it "returns matching dinos when unkn csv col passed as category" do
      expect(dino_add_info_continent.collection.all?{|d| d.additional_info["continent"].include?("America")}).to be true
    end    
  end

  describe "#search(terms)" do
    let(:dino_search) {dir_dex.search({"locomotion" => "Biped", "carnivore" => "carnivore", "continent" => "America"})}

    it "returns a Dinosaurs object" do
      expect(dino_search).to be_an_instance_of Dinosaurs
    end

    it "returns a collection matching all search terms" do
      expect(dino_search.collection.all?(&:carnivore?)).to be true
      expect(dino_search.collection.all?(&:biped?)).to be true
      expect(dino_search.collection.all?{|d| d.additional_info["continent"].include?("America")}).to be true
    end
  end

  describe "#add_dino(Dinosaur)" do
    it "adds Dinosaur to Dinosaurs#collection" do
      expect(Dinosaurs.new.add_dino(dino_obj).collection.first).to eq(dino_obj)
    end
    it "returns a Dinosaurs obj" do
      test_case = Dinosaurs.new.add_dino(dino_obj)
      expect(test_case).to be_an_instance_of Dinosaurs   
    end
  end

  describe "#display" do
    it "outputs all dinosaurs in a collection to standard out" do
      test_case = Dinosaurs.new.add_dino(dino_obj).add_dino(dino_obj)
      expect { test_case.display }.to output("name: Albertonykus, diet: Insectivore, locomotion: Biped, period: Early Cretaceous, continent: North America, description: Earliest known Alvarezsaurid.\n\nname: Albertonykus, diet: Insectivore, locomotion: Biped, period: Early Cretaceous, continent: North America, description: Earliest known Alvarezsaurid.\n\n").to_stdout
    end
  end
end 