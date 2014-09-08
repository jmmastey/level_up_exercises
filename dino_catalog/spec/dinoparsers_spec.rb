require "./dinoparsers"
require "csv"

describe "DinoParser#parse" do
  it "parameterize data to match dinos" do
    headers = %w(NAME PERIOD CONTINENT DIET WEIGHT_IN_LBS WALKING DESCRIPTION)
              .map(&:downcase)
    
    row0 = ["Albertosaurus", "Late Cretaceous", "North America",
            "Carnivore", 2000, "Biped", "Like a T-Rex but smaller."]
    row1 = ["Test1", "Test2", "Test3", "Test4", 0, "Test6", "Test7"]
    
    data = [ row0, row1 ]
    rows = data.map { |d| CSV::Row.new(headers, d) }

    dino_parser = DinoParser.new
    dinos = dino_parser.parse(rows)
    expect(dinos[0].name).to eq("Albertosaurus")
    expect(dinos[0].period).to eq("Late Cretaceous")
    expect(dinos[0].continent).to eq("North America")
    expect(dinos[0].weight).to eq(2000)
    expect(dinos[0].walk).to eq("Biped")
    expect(dinos[0].desc).to eq("Like a T-Rex but smaller.")
  end

  it "takes input from filename" do
    dino_file_path = "dinodex.csv"
    dino_parser = DinoParser.new
    dinos = dino_parser.parse(dino_file_path)

    expect(dinos.size).to eq(9)

    expect(dinos[1].name).to eq("Albertonykus")
    expect(dinos[1].period).to eq("Early Cretaceous")
    expect(dinos[1].continent).to eq("North America")
    expect(dinos[1].diet).to eq("Insectivore")
    expect(dinos[1].weight).to eq(-1)
    expect(dinos[1].walk).to eq("Biped")
    expect(dinos[1].desc).to eq("Earliest known Alvarezsaurid.")

  end
end

describe "AfroDinoParser#parse" do
  it "parameterize data from a matrix to create dinosaurs" do
    headers = %w(genus period carnivore weight walking)
    data = [
      ["Abrictosaurus", "Jurassic", "No", 100, "Biped"],
      ["Test1", "Test2", "Yes", 1000, "Test3"]
    ]
    rows = data.map { |d| CSV::Row.new(headers, d) }
    dino_parser = AfroDinoParser.new
    dinos = dino_parser.parse(rows)

    expect(dinos[0].name).to eq("Abrictosaurus")
    expect(dinos[0].period).to eq("Jurassic")
    expect(dinos[0].continent).to eq("Africa")
    expect(dinos[0].weight).to eq(100)
    expect(dinos[0].walk).to eq("Biped")
    expect(dinos[0].desc).to eq("")
    expect(dinos[0].diet).to eq("Herbivore")

    expect(dinos[1].name).to eq("Test1")
    expect(dinos[1].period).to eq("Test2")
    expect(dinos[1].continent).to eq("Africa")
    expect(dinos[1].weight).to eq(1000)
    expect(dinos[1].walk).to eq("Test3")
    expect(dinos[1].desc).to eq("")
    expect(dinos[1].diet).to eq("Carnivore")
  end

  it "parameterize data from a csv file" do
    afro_dino_file_path = "african_dinosaur_export.csv"
    dino_parser = AfroDinoParser.new
    dinos = dino_parser.parse(afro_dino_file_path)

    expect(dinos[0].name).to eq("Abrictosaurus")
    expect(dinos[0].period).to eq("Jurassic")
    expect(dinos[0].continent).to eq("Africa")
    expect(dinos[0].weight).to eq(100)
    expect(dinos[0].walk).to eq("Biped")
    expect(dinos[0].desc).to eq("")
  end
end

describe "DinoTokenParser#parse" do
  it "takes in a string and produces a token " \
     "chain" do
    parser = DinoTokenParser.new

    tokens = parser.parse("AND name > A; SORT weight")

    expect(tokens.size).to eq(2)

    expect(tokens[0].field).to eq("name")
    expect(tokens[0].op).to eq(">")
    expect(tokens[0].arg).to eq("A")

    expect(tokens[1].field).to eq("weight")
  end
end
