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
    let(:wire_cut) { disarm_wire.cut }

    context "when intact" do
      it "cuts the wire" do
        wire_cut
        expect(disarm_wire).not_to be_intact
      end

      it "returns true" do
        expect(wire_cut).to be true
      end
    end

    context "when not intact" do
      before(:each) { disarm_wire.cut }

      it "returns false" do
        expect(wire_cut).to be false
      end
    end
  end
end
