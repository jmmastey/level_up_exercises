require_relative "../dino_runner"

SPEC_ROOT = File.expand_path("..", __FILE__)
TEST_DIR_PATH = SPEC_ROOT + "/test"

FORMAT_ONE_FILE_DATA = "NAME,PERIOD,CONTINENT,DIET,WEIGHT_IN_LBS,WALKING,DESCRIPTION\nAlbertosaurus,Late Cretaceous,North America,Carnivore,2000,Biped,Like a T-Rex but smaller.\nAlbertonykus,Early Cretaceous,North America,Insectivore,,Biped,Earliest known Alvarezsaurid.\nBaryonyx,Early Cretaceous,Europe,Piscivore,6000,Biped,One of the only known dinosaurs with a fish-only diet.\nDeinonychus,Early Cretaceous,North America,Carnivore,150,Biped,\nDiplocaulus,Late Permian,North America,Carnivore,,Quadruped,They actually had fins on the side of their body."

FORMAT_TWO_FILE_DATA = "Genus,Period,Carnivore,Weight,Walking\nAbrictosaurus,Jurassic,No,100,Biped\nAfrovenator,Jurassic,Yes,,Biped\nCarcharodontosaurus,Albian,Yes,3000,Biped\nParalititan,Cretaceous,No,120000,Quadruped\nSuchomimus,Cretaceous,Yes,10400,Biped"

def stage_csv_directory
  Dir.mkdir(TEST_DIR_PATH) unless File.exists?(TEST_DIR_PATH)
  File.open("#{TEST_DIR_PATH}/file_one.csv", "w") { |file| file.write(FORMAT_ONE_FILE_DATA)}
  File.open("#{TEST_DIR_PATH}/file_two.csv", "w") { |file| file.write(FORMAT_TWO_FILE_DATA)}
  [TEST_DIR_PATH]
end


describe DinoRunner do

  let(:runner) { DinoRunner.new(stage_csv_directory)}
  let(:dinosaurs) {Dinosaurs.from_directory(stage_csv_directory.first)}
  let(:default_runner) {DinoRunner.new}
  let(:default_dinosaurs) {Dinosaurs.from_directory}

  describe "#initialize" do
    it "creates a DinoRunner obj" do
      expect(runner).to be_an_instance_of DinoRunner
    end
    it "populates a dino_catalog w/ a Dinosaurs obj" do
      expect(runner.dino_catalog.class).to eq(dinosaurs.class)
      expect(runner.dino_catalog.collection.count).to eq(dinosaurs.collection.count)
    end
    it "defaults to csv directory in dinosaurs if no arg given" #do
    #   expect(default_runner.dino_catalog).to eq(default_dinosaurs)
    # end
    it "it uses provided dir for csvs if passed as ARGV" 
    # no idea how to do this
    it "calls #run"
    # or this
  end

  describe "#run" do
    # no idea how to test any of this
    it "calls #greeting_display at opening" 
    it "calls #options_display at opening"
    it "loops until it receives the break command"
    it "pulls in user's command line requests"
    it "calls the correct method w/ correct args based on user command"
    it "displays user requested info to terminal"
  end

  describe "#filter_catalog(filter_terms)" do
    filter_args_shorthand = ["-b", "-c", "-2"]
    filter_args_verbose = ["big", "carnivorus", "biped"]
    filter_args_bc = ["-c", "-b"]
    filter_args_2b = ["-2", "-b"]
    filter_args_2c = ["-2", "-c"]
    filter_args_b = ["-b"]
    filter_args_2 = ["-2"]
    filter_args_c = ["-c"]

    it "returns a Dinosaurs collection" do
      expect(runner.filter_catalog(filter_args_shorthand)).to be_an_instance_of Dinosaurs
    end
    it "accepts an array of arg filters" #no idea
    it "correctly parses filter terms & applies methods" do
      expect(runner.filter_catalog(filter_args_b).collection.all?{ |d| d.big?}).to be_truthy
      expect(runner.filter_catalog(filter_args_2).collection.all?{ |d| d.biped? }).to be_truthy
      expect(runner.filter_catalog(filter_args_c).collection.all?{ |d| d.carnivore? }).to be_truthy
    end

    it "applies a method for each arg" do
      expect(runner.filter_catalog(filter_args_verbose).collection.all?{ |d| d.carnivore? && d.biped? && d.big?}).to be_truthy
      expect(runner.filter_catalog(filter_args_shorthand).collection.all?{ |d| d.carnivore? && d.biped? && d.big?}).to be_truthy
      expect(runner.filter_catalog(filter_args_bc).collection.all?{ |d| d.carnivore? && d.big?}).to be_truthy
      expect(runner.filter_catalog(filter_args_2b).collection.all?{ |d| d.biped? && d.big?}).to be_truthy
      expect(runner.filter_catalog(filter_args_2c).collection.all?{ |d| d.carnivore? && d.biped? }).to be_truthy
    end
  end

  describe "#parse_search_terms(search_terms)" do
    it "returns a hash of k-v search requests" do
      expect(runner.parse_search_terms(["Continent:America", "shape:big", "color:green"])).to eq({"continent" => "america", "shape" => "big", "color" => "green"})
    end
    it "downcases all the search terms" do
      expect(runner.parse_search_terms(["Continent:America"])).to eq({"continent" => "america"})
    end
  end

  describe "#options_display" do
    it "prints a list of command options to the terminal" do
      expect {default_runner.options_display}.to output("-h or help: access this help menue\n-e or exit: exit the program\n-l or list: view a list of all dinos\n-b or big: view a list of dino >= 4000lb\n-c or carnivorus: view a list of all non-plant eating dinosaurs\n-2 or biped: view a list of all bipedal dinosaurs\n-p or period <period>: view a list of dinosaurs from the <period> period\n-f or filter <big/biped/carnivorus or their abbreviations>: view a listed filtered by all included criteria\n-s or search category:<term> category:<term>... : view a list of dinos filtered by search criteria\n").to_stdout
    end
  end

  describe "#greeting_display" do
    it "prings a welcome greeting to terminal" do
      expect {default_runner.greeting_display}.to output("Welcome to Di-Facto, your presumed source for prehistoric points of interest\n").to_stdout
    end
  end
end