require "spec_helper"
require_relative "../bomb"

describe Bomb do
  let(:bomb) { Bomb.new }

  describe "#initialize" do
    it "is initially decatived" do
      expect(bomb).not_to be_activated
    end

    it "has a default activation code of 1234" do
      expect(bomb.activation_code).to eq(1234)
    end

    it "has a default deactivation code of 0000" do
      expect(bomb.deactivation_code).to eq(0)
    end

    it "can have an activation code set on boot" do
      bomb = Bomb.new(activation_code: 1111)
      expect(bomb.activation_code).to eq(1111)
    end

    it "can have an deactivation code set on boot" do
      bomb = Bomb.new(deactivation_code: 1111)
      expect(bomb.deactivation_code).to eq(1111)
    end

    it "must have an integer activation code between 0-9999" do
      expect { Bomb.new(activation_code: -5) }.to raise_error ArgumentError
      expect { Bomb.new(activation_code: 0.5) }.to raise_error ArgumentError
      expect { Bomb.new(activation_code: 10000) }.to raise_error ArgumentError
      expect { Bomb.new(activation_code: "words") }.to raise_error ArgumentError
    end

    it "must have an integer deactivation code between 0-9999" do
      expect { Bomb.new(deactivation_code: -5) }.to raise_error ArgumentError
      expect { Bomb.new(deactivation_code: 0.5) }.to raise_error ArgumentError
      expect { Bomb.new(deactivation_code: 10000) }.to raise_error ArgumentError
      expect { Bomb.new(deactivation_code: "words") }.to raise_error ArgumentError
    end
  end
end
