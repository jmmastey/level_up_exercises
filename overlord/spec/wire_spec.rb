require_relative "../bomb"
require_relative "../wire"

describe Wire do
  let(:bomb) { Bomb.new }
  let(:wire) { Wire.new(bomb, :red) }

  it "has a color" do
    expect(wire.color).to be(:red)
  end

  it "initializes as intact" do
    expect(wire).to be_intact
  end

  describe "#snip" do
    it "cuts the wire, making it register as no longer intact" do
      wire.snip
      expect(wire).not_to be_intact
    end
  end
end
