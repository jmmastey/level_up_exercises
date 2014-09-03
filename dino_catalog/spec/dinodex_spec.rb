require './dinodex'
require './dinoparsers.rb'

describe DinoDex,"#query" do
  it "should match dinos by the block statement" do
  
  dino_file = "dinodex.csv"
  dino_parser = DinoParser.new
  dinos = dino_parser.parse(dino_file)

  dinodex = DinoDex.new
  dinodex.load(dinos)

  result = dinodex.query(:name,:==,'Albertosaurus').result

  expect(result.size).to eq(1)
  expect(result[0].name).to eq("Albertosaurus")
  expect(result[0].period).to eq("Late Cretaceous")
  expect(result[0].continent).to eq("North America")
  expect(result[0].diet).to eq("Carnivore")
  expect(result[0].weight).to eq(2000)
  expect(result[0].walk).to eq("Biped")
  expect(result[0].desc).to eq("Like a T-Rex but smaller.")

  result = dinodex.query("name",">","M").result
  expect(result.size).to eq(3)

  result = dinodex.query("name",">","M").and("weight",">",4000).result

  expect(result.size).to eq(1)
  expect(result[0].name).to eq("Yangchuanosaurus") 

  end

  it "we should make sure sort works as well" do
    dino_file = "dinodex.csv"
    dino_parser = DinoParser.new
    dinos = dino_parser.parse(dino_file)
    
    dinodex = DinoDex.new
    dinodex.load(dinos)

    result = dinodex.new_query.sort(:name).result

    expect(result.size).to eq(9)
    expect(result[0].name).to eq("Albertonykus")
    expect(result[1].name).to eq("Albertosaurus")
    expect(result[2].name).to eq("Baryonyx")
    expect(result[3].name).to eq("Deinonychus")
    expect(result[4].name).to eq("Diplocaulus")
    expect(result[5].name).to eq("Giganotosaurus")
    expect(result[6].name).to eq("Megalosaurus")
    expect(result[7].name).to eq("Quetzalcoatlus")
    expect(result[8].name).to eq("Yangchuanosaurus")

  end
end
