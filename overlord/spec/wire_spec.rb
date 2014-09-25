require "rspec"

require_relative "../src/wire"

describe Wire do
  context "upon creation" do
    let(:wire) { Wire.new(:blue) }
    it "should have a color" do
      expect(wire.color).to eq(:blue)
    end

    it "should not be snipped" do
      expect(wire).not_to be_snipped
    end
  end

  context "upon being snipped" do
    let(:wire) do
      wire = Wire.new(:blue)
      wire.snip
      wire
    end

    it "should be snipped" do
      expect(wire).to be_snipped
    end
  end
end
