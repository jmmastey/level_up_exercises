require_relative "../lib/wire"
require_relative "../lib/wire_generator"

describe WireGenerator do
  let(:generator) { WireGenerator.new("./valid_wire_colors.dat") }

  it "generates a random collection of wires" do
    wires = generator.generate_wires
    expect(wires).to be_an(Enumerable)

    wires.each { |wire| expect(wire).to be_a(Wire) }
  end

  it "allows the user to specify how many wires to generate" do
    wires = generator.generate_wires(5)
    expect(wires.count).to eq(5)

    wires = generator.generate_wires(3)
    expect(wires.count).to eq(3)
  end
end
