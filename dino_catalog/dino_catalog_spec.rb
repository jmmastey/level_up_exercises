require 'rspec'
require_relative 'dino_catalog'

describe DinoCatalog do 
  it "should initialize with an empty array" do
    expect(DinoCatalog.new.dino_array).to be_an Array
  end

  it "should parse a CSV file" do 
    dino_log = DinoCatalog.new
    dino_log.parse('dinodex.csv')
    expect(dino_log.csv_array).to be_a CSV
  end

  it "should create an array of Dinos" do
    dino_log = DinoCatalog.new
    dino_log.parse('dinodex.csv')
    dino_log.make_dinos
    binding.pry
    expect(dino_log.dino_array.first).to be_a Dino
  end
end
