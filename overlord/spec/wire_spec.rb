require "spec_helper"

describe Wire do
  let(:disarm_wire) { described_class.new(:disarm) }
  let(:detonating_wire) { described_class.new(:detonate) }

  describe "#new" do
    it "is initialized with a type" do
      expect { disarm_wire }.not_to raise_error
      expect { detonating_wire }.not_to raise_error
    end

    it "is intact" do
      expect(disarm_wire).to be_intact
      expect(detonating_wire).to be_intact
    end
  end

  describe "#cut" do
    before(:each) { disarm_wire.cut }

    it "cuts the wire" do
      expect(disarm_wire).not_to be_intact
    end

    it "returns the wire" do
      expect(disarm_wire.cut).to eq(disarm_wire)
    end
  end
end
