require 'rspec'
require 'spec_helper'
require 'dinodex_loader'
require "dinosaur"

describe DinodexLoader, "#DinodexLoad" do
  before(:each) do
    @output = double('output').as_null_object
    @directory = "./inputs"
  end

  it "finds 2 files in our csv directory" do
    expect(DinodexLoader.find_csv_files(@directory).length).to be(2)
  end

  it "find african_dinosaur_export.csv" do
    expect(DinodexLoader.find_csv_files(@directory).to_s).to include("african_dinosaur_export.csv")
  end

  it "find dinodex.csv" do
    expect(DinodexLoader.find_csv_files(@directory).to_s).to include("dinodex.csv")
  end

  it "raises an error when file not found" do
    file = "/asdv.csv"
    expect { DinodexLoader.load_csv_file(@directory + file) }.to raise_error("File #{@directory}#{file} not found")
  end

  it "loads the dinodex CSV file with 9 dinosaurs" do
    expect(DinodexLoader.load_csv_file("#{@directory}/dinodex.csv").length).to be(9)
  end

  #TODO check for a specific dinosaur in one of these files and validate it's data?

  it "parses weight_in_lbs and weight to dinosaur.weight" do
    dinosaur = Dinosaur.new
    dinosaur.weight="0"
    expect(DinodexLoader.parse_csv_field(dinosaur, "1000", "weight_in_lbs"))
    expect(dinosaur.weight).to eq("1000")
  end

  it "parses carnivore = no to herbivore" do
    dinosaur = Dinosaur.new
    expect(DinodexLoader.parse_csv_field(dinosaur, "no", "carnivore"))
    expect(dinosaur.diet).to eq("Herbivore")
  end

end
