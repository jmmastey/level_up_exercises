require "rspec/expectations"

require_relative "../src/bomb"
require_relative "../src/wire_box"
require_relative "../src/bomb_timer"
require_relative "../src/bomb_code_box"

describe Bomb do
  let(:bad_device) { Object.new }

  let(:triggered_device) do
    device = Object.new
    def device.triggered?
      true
    end
    device
  end

  let(:device) do
    device = Object.new
    def device.triggered?
      false
    end
    device
  end

  context "upon creation" do
    let(:bomb) do
      devices = [device, device, device]
      devices = Hash[devices.each_with_index.map {|device, idx| [idx, device]}]
      described_class.new(devices)
    end

    it "should get devices attached to the bomb" do
      expect(bomb.devices.size).to eq(3)
    end

    it "should not be not be exploded" do
      expect(bomb).not_to be_exploded
    end
  end

  context "upon a triggered device" do
    let(:bomb) do
      devices = [device, device, device, triggered_device, device]
      devices = Hash[devices.each_with_index.map {|device, idx| [idx, device]}]
      described_class.new(devices)
    end

    it "should be exploded" do
      expect(bomb).to be_exploded
    end
  end

  context "creating with bad device" do
    it "should not be allowed to be created" do
      expect { described_class.new({ 0 => bad_device }) }.to raise_error
    end
  end
end
