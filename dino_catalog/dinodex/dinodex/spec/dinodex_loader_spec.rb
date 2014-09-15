require "rspec"
require "spec_helper"
require "dinodex_loader"
require "dinosaur"

describe DinodexLoader, "#DinodexLoad" do
  before(:each) do
    @directory = "./inputs"
    @dinodex_loader = DinodexLoader.new
  end

  it "finds 2 files in our csv directory" do
    expect(@dinodex_loader.find_csv_files(@directory).length).to be(2)
  end

  it "find african_dinosaur_export.csv" do
    find_file_output = @dinodex_loader.find_csv_files(@directory).to_s
    expect(find_file_output).to include("african_dinosaur_export.csv")
  end

  it "find dinodex.csv" do
    find_file_output = @dinodex_loader.find_csv_files(@directory).to_s
    expect(find_file_output).to include("dinodex.csv")
  end

  it "raises an error when file not found" do
    file = "/asdv.csv"
    expect do
      @dinodex_loader.load_csv_file(@directory + file)
    end.to raise_error("File #{@directory}#{file} not found")
  end

  it "loads the dinodex CSV file with 9 dinosaurs" do
    dino_file = "#{@directory}/dinodex.csv"
    expect(@dinodex_loader.load_csv_file(dino_file).length).to be(9)
  end

  it "parses name field to dinosaur.name" do
    @dinosaurs = @dinodex_loader.load_csv_file("#{@directory}/dinodex.csv")
    expect(@dinosaurs.select do |dino|
      dino.name == "Megalosaurus"
    end.length).to eq(1)
  end

  it "parses period field to dinosaur.period" do
    @dinosaurs = @dinodex_loader.load_csv_file("#{@directory}/dinodex.csv")
    expect(@dinosaurs.select do |dino|
      dino.name == "Megalosaurus"
    end[0].period).to eq("Jurassic")
  end

end

describe DinodexLoader, "African CSV Parsing" do
  before(:each) do
    @directory = "./inputs"
    @dinodex_loader = DinodexLoader.new
    african_csv = "#{@directory}/african_dinosaur_export.csv"
    @dinosaurs = @dinodex_loader.load_csv_file(african_csv)
  end

  it "parses oddity field genus to name" do
    expect(@dinosaurs.select do |dino|
      dino.name == "Afrovenator"
    end.length).to eq(1)
  end

  it "parses alt field weight_in_lbs and weight to dinosaur.weight" do
    expect(@dinosaurs.select do |dino|
      dino.name == "Abrictosaurus"
    end[0].weight).to eq("100")
  end

  it "parses alt field carnivore = no to herbivore" do
    expect(@dinosaurs.select do |dino|
      dino.name == "Abrictosaurus"
    end[0].diet).to eq("Herbivore")
  end

  it "parses alt field carnivore = yes to carnivore" do
    expect(@dinosaurs.select do |dino|
      dino.name == "Afrovenator"
    end[0].diet).to eq("Carnivore")
  end

end
