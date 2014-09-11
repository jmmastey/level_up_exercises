require "./dinocommand"
require "./dinodex"
require "./dinoparsers"

def test_dinodex
  dino_parser = DinoParser.new
  dinos = dino_parser.parse("dinodex.csv")

  dinodex = DinoDex.new(dinos)

  dinodex
end

describe "AndToken#handle" do
  it "it should handle a query for a token, arg, op, field" do

    query = test_dinodex.new_query

    token = AndCommand.new(["AND", :name, :==, "Albertosaurus"])

    expect(token.field).to eq(:name)
    expect(token.op).to eq(:==)
    expect(token.arg).to eq("Albertosaurus")

    result = token.apply_to(query).result

    expect(result.size).to eq(1)
    expect(result[0].name).to eq("Albertosaurus")
  end
end

describe "SortToken#execute" do
  it "it should handle a query for a sort token" do
    dinodex = test_dinodex

    token = SortCommand.new(["SORT", :name])

    expect(token.field).to eq(:name)

    result = token.apply_to(dinodex.new_query).result

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
