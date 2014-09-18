require "rspec/collection_matchers"
require_relative "../lib/wire"
require_relative "../lib/wire_box"
require_relative "_helpers"

describe WireBox do
  let(:wire) do
    w = Wire.new(:red)
    w.type = :disarm
    w
  end

  let(:wireless_box) { WireBox.new }

  let(:wirebox) do
    WireBox.new(wire)
  end

  let(:complex_wirebox) do
    get_test_wire_box
  end

  it "initializes without wires" do
    expect(wireless_box).to have(0).wires
  end

  it "can initialize with a colleciton of one or more wires" do
    expect(wirebox).to have(1).wires
  end

  it "initializes in the disabled state" do
    expect(wireless_box.state).to eq(:disabled)
  end

  describe "#disabled?" do
    it "returns true if state is disabled, false otherwise" do
      expect(wireless_box).to be_disabled
      expect(wirebox).not_to be_disabled
    end
  end

  describe "#disarm_wires" do
    it "gets the wires of the type :disarm" do
      expect(complex_wirebox).to have(2).disarm_wires

      disarm_wires = complex_wirebox.disarm_wires
      expect(disarm_wires.all? { |wire| wire.is_type?(:disarm) }).to be true
    end
  end

  describe "#exploding?" do
    it "returns true if state is exploding, false otherwise" do
      complex_wirebox.exploding_wires.first.snip
      expect(complex_wirebox).to be_exploding
    end
  end

  describe "#exploding_wires" do
    it "gets the wires of the type :exploding" do
      expect(complex_wirebox).to have(2).exploding_wires

      exploding_wires = complex_wirebox.exploding_wires
      expect(exploding_wires.all? { |wire| wire.is_type?(:exploding) }).to be true
    end
  end

  describe "#intact?" do
    it "returns true if state is intact, false otherwise" do
      expect(wirebox).to be_intact
      expect(wireless_box).not_to be_intact
    end
  end

  describe "#state" do
    context "When all exploding wires and at least one disarm wire are intact" do
      it "is intact" do
        expect(wirebox.state).to eq(:intact)
      end
    end

    context "When all disarm wires are cut" do
      it "is disabled" do
        complex_wirebox.disarm_wires.each(&:snip)
        expect(complex_wirebox.state).to eq(:disabled)
      end
    end

    context "When at least one exploding wire is cut and at least one disarm wire is intact" do
      it "is exploding" do
        complex_wirebox.exploding_wires.first.snip
        expect(complex_wirebox.state).to eq(:exploding)
      end
    end
  end

  describe "#send_to_device" do
    let (:device) { double("bomb", exploded?: false, intact?: true) }

    it "sends a message to its device and returns the result" do
      wirebox.device = device
      result = wirebox.send_to_device(:intact?)

      expect(result).to be true
    end

    it "raises a NoDeviceError if no device exists" do
      expect { wirebox.send_to_device(:length) }.to raise_error(NoDeviceError)
    end

    it "raises a DisabledError if the wirebox is not intact" do
      wirebox.device = device
      wire.snip

      expect { wirebox.send_to_device(:length) }.to raise_error(DisabledError)
    end
  end
end
