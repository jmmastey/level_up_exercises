require_relative "../wire"

describe Wire do
  let(:wire) { Wire.new(:red) }

  it "has a color" do
    expect(Wire.get_valid_colors).to include(wire.color)
  end

  it "rejects bad colors" do
    expect { Wire.new(:fire) }.to raise_error(ArgumentError)
  end

  it "initializes as intact" do
    wire = Wire.new(:red)
    expect(wire).to be_intact
  end

  describe "#snip" do
    it "cuts the wire, making it register as no longer intact" do
      wire.snip
      expect(wire).not_to be_intact
    end
  end
end
