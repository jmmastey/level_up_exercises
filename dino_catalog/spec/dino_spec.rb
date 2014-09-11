require "./dino"

describe "#checkingInit" do
  it "checking if class definition" \
     "has all vars initialzied" do
    dino = Dinosaur.new(name: "Name",
                        period: "Period",
                        continent: "Continent",
                        diet: "Diet",
                        weight: 10_000,
                        walk: "Walk",
                        desc: "This is a description")

    expect(dino.name).to eq("Name")
    expect(dino.period).to eq("Period")
    expect(dino.continent).to eq("Continent")
    expect(dino.diet).to eq("Diet")
    expect(dino.weight).to eq(10_000)
    expect(dino.walk).to eq("Walk")
    expect(dino.desc).to eq("This is a description")

  end
end
