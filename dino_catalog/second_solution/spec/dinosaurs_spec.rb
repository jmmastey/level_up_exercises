require_relative "../dinosaurs"


SPEC_ROOT = File.expand_path("..", __FILE__)
TEST_DIR_PATH = SPEC_ROOT + "/test"

FORMAT_ONE_FILE_DATA = "NAME,PERIOD,CONTINENT,DIET,WEIGHT_IN_LBS,WALKING,DESCRIPTION\nAlbertosaurus,Late Cretaceous,North America,Carnivore,2000,Biped,Like a T-Rex but smaller.\nAlbertonykus,Early Cretaceous,North America,Insectivore,,Biped,Earliest known Alvarezsaurid.\nBaryonyx,Early Cretaceous,Europe,Piscivore,6000,Biped,One of the only known dinosaurs with a fish-only diet.\nDeinonychus,Early Cretaceous,North America,Carnivore,150,Biped,\nDiplocaulus,Late Permian,North America,Carnivore,,Quadruped,They actually had fins on the side of their body."

FORMAT_TWO_FILE_DATA = "Genus,Period,Carnivore,Weight,Walking\nAbrictosaurus,Jurassic,No,100,Biped\nAfrovenator,Jurassic,Yes,,Biped\nCarcharodontosaurus,Albian,Yes,3000,Biped"

def stage_csv_files
  Dir.mkdir(TEST_DIR_PATH) unless File.exists?(TEST_DIR_PATH)
  File.open("#{TEST_DIR_PATH}/file_one.csv", "w") { |file| file.write(FORMAT_ONE_FILE_DATA)}
  File.open("#{TEST_DIR_PATH}/file_two.csv", "w") { |file| file.write(FORMAT_TWO_FILE_DATA)}
  TEST_DIR_PATH
end





describe Dinosaurs do

  let(:default_dex) { Dinosaurs.new }
  let(:test_deck) {Dinosaurs.new(stage_csv_files)}

  it "creates a Dinosaurs object" do
    expect(default_dex).to be_an_instance_of Dinosaurs
  end

  it "accepts an optional file path on instantiation" do
    expect(test_deck).to be_an_instance_of Dinosaurs
  end

  it "reads multiple files when instantiating" do
    expect(test_deck.dinosaurs.count).to eq(8)
  end

  it "populates #dinosaurs with Dinosaur objs" do
    expect(test_deck.dinosaurs.all?{|d| d.class == Dinosaur}).to be true
  end


end 