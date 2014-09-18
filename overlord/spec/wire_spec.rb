require_relative "../lib/wire.rb"

describe Wire do
  let(:wire) { Wire.new(:red) }

  it "is initialized in the intact state" do
    expect(wire).to be_intact
  end

  it "has a color" do
    expect(wire.color).to eq(:red)
  end

  describe "#is_type?" do
    it "returns true if this object's type matches the given type" do
      wire.type = :disarm
      expect(wire.is_type?(:disarm)).to be true
    end
  end

  describe "#snip" do
    it "snips the wire" do
      wire.snip
      expect(wire).to be_cut
    end

    it "raises an error when the wire is already cut" do
      wire.snip
      expect { wire.snip }.to raise_error(RuntimeError)
    end
  end
end
