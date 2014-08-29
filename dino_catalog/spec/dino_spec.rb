require './dino'

describe "#checkingInit" do
  it "I'm new to ruby, I'm checking" +
     "if class def worked" do
  dino = Dinosaur.new("Name","Period","Continent","Diet",10000,"Walk","This is a description")
  
  expect(dino.name).to eq("Name")
  expect(dino.period).to eq("Period")
  expect(dino.continent).to eq("Continent")
  expect(dino.diet).to eq("Diet")
  expect(dino.weight).to eq(10000)
  expect(dino.walk).to eq("Walk")
  expect(dino.desc).to eq("This is a description")

  end
end
