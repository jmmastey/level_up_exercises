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
      devices = { a: device, b: device, c: device }
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
      devices = { a: device, bad: triggered_device, c: device }
      described_class.new(devices)
    end

    it "should be exploded" do
      expect(bomb).to be_exploded
    end
  end

  context "creating with bad device" do
    it "should not be allowed to be created" do
      expect { described_class.new(test: bad_device) }.to raise_error
    end
  end

  context "upon creation with devices" do
    let(:bomb) do
      described_class.new(a: device, b: triggered_device)
    end

    it "should create methods to fetch from the hash" do
      expect(bomb.devices[:a]).to eq(device)
      expect(bomb.devices[:b]).to eq(triggered_device)
    end

    it "should throw an error if not in device" do
      expect { bomb.not_there }.to raise_error
    end
  end
end
