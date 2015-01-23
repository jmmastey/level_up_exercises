require 'spec_helper'

describe Bomb do
  describe "#new" do
    it "raises an error if the activation code is not a 4-digit number" do
      expect { Bomb.new("1", "2321") }.to raise_error(ArgumentError)
    end

    it "raises an error if the activation code is not a 4-digit number" do
      expect { Bomb.new("1234", "2") }.to raise_error(ArgumentError)
    end

    subject(:sample_bomb) { Bomb.new("", "") }

    it "defaults to 1234 as the activation code if no code is entered" do
      sample_bomb.try_to_activate("1234")
      expect(sample_bomb.active).to eq(true)
    end

    it "defaults to 0000 as the deactivation code is no code is entered" do
      sample_bomb.try_to_activate("1234")
      sample_bomb.try_to_deactivate("0000")
      expect(sample_bomb.active).to eq(false)
    end

    it "is initialized with 3 deactivation attempts remaining" do
      expect(sample_bomb.attempts_remaining).to eq(3)
    end

    it "is not activated upon creation" do
      expect(sample_bomb.active).to eq(false)
    end

    it "has not exploded yet" do
      expect(sample_bomb.exploded?).to eq(false)
    end
  end

  describe "#try_to_activate" do

    subject(:sample_bomb) { Bomb.new("", "") }

    it "does not activate if the activation code is not correct" do
      sample_bomb.try_to_activate("1111")
      expect(sample_bomb.active).to eq(false)
    end

  	it "activates when the correct activation code is entered" do
      sample_bomb.try_to_activate("1234")
      expect(sample_bomb.active).to eq(true)
    end

    it "does nothing if the bomb is already active" do
      sample_bomb.try_to_activate("1234")
      expect(sample_bomb.active).to eq(true)
    end

    it "does not activate if the bomb has exploded" do
      sample_bomb.try_to_activate("1234")
      3.times do
        sample_bomb.try_to_deactivate("1111")
      end
      sample_bomb.try_to_activate("1234")
      expect(sample_bomb.exploded?).to eq(true)
      expect(sample_bomb.active).to eq(false)
    end
  end

  describe "#try_to_deactivate" do

    subject(:sample_bomb) { Bomb.new("", "") }

    it "deactivates the bomb when the correct deactivation code is entered" do
      sample_bomb.try_to_deactivate("0000")
      expect(sample_bomb.active).to eq(false)
      expect(sample_bomb.exploded?).to eq(false)
    end

    it "does not explode after two incorrect deactivation attempts" do
      sample_bomb.try_to_activate("1234")
      2.times do
        sample_bomb.try_to_deactivate("4444")
        expect(sample_bomb.active).to eq(true)
        expect(sample_bomb.exploded?).to eq(false)
      end

    end
    it "explodes after three incorrect deactivation attempts" do
      sample_bomb.try_to_activate("1234")
      3.times do
        sample_bomb.try_to_deactivate("4444")
      end
      expect(sample_bomb.exploded?).to eq(true)
      expect(sample_bomb.attempts_remaining).to eq(0)
    end

    it "does nothing after exploding" do
      sample_bomb.try_to_activate("1234")
      4.times do
        sample_bomb.try_to_deactivate("4444")
      end
      expect(sample_bomb.exploded?).to eq(true)
      expect(sample_bomb.attempts_remaining).to eq(0)
    end
  end

  describe "#exploded?" do

    subject(:sample_bomb) { Bomb.new("", "") }

    it "shows that the bomb has not exploded upon boot" do
      expect(sample_bomb.exploded?).to eq(false)
    end

    it "shows that the bomb has not exploded after activation" do
      sample_bomb.try_to_activate("1234")
      expect(sample_bomb.exploded?).to eq(false)
    end

    it "does not explode after one or two incorrect deactivation attempts" do
      sample_bomb.try_to_activate("1234")
      2.times do
        sample_bomb.try_to_deactivate("4444")
        expect(sample_bomb.exploded?).to eq(false)
      end
    end

    it "explodes after three incorrect deactivation attempts" do
      sample_bomb.try_to_activate("1234")
      3.times do
        sample_bomb.try_to_deactivate("4444")
      end
      expect(sample_bomb.exploded?).to eq(true)
    end
  end
end
