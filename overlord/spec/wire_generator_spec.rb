require_relative "../wire"
require_relative "../wire_generator"

describe WireGenerator do
  let(:bomb) { nil } # use mock bomb
  let(:generator) { WireGenerator.new }

  it "generates a random collection of wires" do
    wires = generator.generate_wires(bomb)
    expect(wires).to be_an(Enumerable)

    wires.each { |wire| expect(wire).to be_a(Wire) }
  end

  it "allows the user to specify how many wires to generate" do
    wires = generator.generate_wires(bomb, 5)
    expect(wires.count).to eq(5)

    wires = generator.generate_wires(bomb, 3)
    expect(wires.count).to eq(3)
  end
end
