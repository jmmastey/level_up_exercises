require "spec_helper"
require_relative "../bomb"

describe Bomb do
  let(:bomb) { Bomb.new }

  describe "#initialize" do
    it "is initially is deacatived" do
      expect(bomb).not_to be_activated
      expect(bomb.status).to eq("deactivated")
    end

    it "is initially has not exploded..." do
      expect(bomb).not_to be_exploded
    end

    it "has unsnipped wires (not disarmed) on boot" do
      expect(bomb).not_to be_disarmed
    end

    it "has a default activation code of 1234" do
      expect(bomb.activation_code).to eq("1234")
    end

    it "has a default deactivation code of 0000" do
      expect(bomb.deactivation_code).to eq("0000")
    end

    it "can have custom codes set on boot" do
      bomb = Bomb.new("1111", "4444")
      expect(bomb.activation_code).to eq("1111")
      expect(bomb.deactivation_code).to eq("4444")
    end

    it "sets codes to defaults if initialized with empty string" do
      bomb = Bomb.new("", "")
      expect(bomb.activation_code).to eq("1234")
      expect(bomb.deactivation_code).to eq("0000")
    end

    it "must have a 4-digit string activation code" do
      expect { Bomb.new("-5") }.to raise_error ArgumentError
      expect { Bomb.new("0.5") }.to raise_error ArgumentError
      expect { Bomb.new("10000") }.to raise_error ArgumentError
      expect { Bomb.new("words") }.to raise_error ArgumentError
      expect { Bomb.new(1234) }.to raise_error ArgumentError
    end

    it "must have a 4-digit string deactivation code" do
      expect { Bomb.new("1111", "-5") }.to raise_error ArgumentError
      expect { Bomb.new("1111", "0.5") }.to raise_error ArgumentError
      expect { Bomb.new("1111", "10000") }.to raise_error ArgumentError
      expect { Bomb.new("1111", "words") }.to raise_error ArgumentError
      expect { Bomb.new("1111", 1234) }.to raise_error ArgumentError
    end
  end

  describe "#activate" do
    it "should be activated on correct activation code entry" do
      bomb.activate("1234")
      expect(bomb).to be_activated
    end

    it "should have 0 deactivation attempts after activation" do
      bomb.activate("1234")
      expect(bomb.deactivation_attempts).to eq(0)
    end

    it "should remain deactivated if incorrect activation code entry" do
      bomb.activate("1111")
      expect(bomb).not_to be_activated
    end

    it "should stay activated upon additional activation entries" do
      2.times { bomb.activate("1234") }
      expect(bomb).to be_activated
      expect(bomb.status).to eq("activated")
    end
  end

  describe "#deactivate" do
    it "should become inactive upon correct entry of deactivation code" do
      bomb.activate("1234")
      bomb.deactivate("0000")
      expect(bomb).not_to be_activated
      expect(bomb.status).to eq("deactivated")
    end

    it "should stay active upon entry of incorrect deactivation code" do
      bomb.activate("1234")
      bomb.deactivate("1234")
      expect(bomb).to be_activated
    end

    it "should explode after three incorrect deactivation attempts" do
      bomb.activate("1234")
      3.times { bomb.deactivate(1) }
      expect(bomb).to be_exploded
      expect(bomb.status).to eq("exploded")
    end

    it "should reset to 0 deactivation attempts after re-activation" do
      bomb.activate("1234")
      bomb.deactivate("2222")
      bomb.deactivate("0000")
      bomb.activate("1234")
      expect(bomb.deactivation_attempts).to eq(0)
    end
  end

  describe "#snip_wires" do
    it "should be disarmed with snipped wires" do
      bomb.snip_wires
      expect(bomb).to be_disarmed
      expect(bomb.status).to eq("disarmed")
    end

    it "cannot be activated once wires are snipped" do
      bomb.snip_wires
      bomb.activate("1234")
      expect(bomb.status).to eq("disarmed")
    end
  end
end
