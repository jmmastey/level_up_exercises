require 'spec_helper'

describe Bomb do
  subject(:bomb) { Bomb.new("", "") }
  
  describe "#new" do
    it "defaults to 1234/0000 codes with no input" do
      bomb.activate("1234")
      expect(bomb).to be_activated
      bomb.deactivate("0000")
      expect(bomb).not_to be_activated
      expect(bomb).not_to be_exploded
    end

    it "is initialized with 3 deactivation attempts" do
      expect(bomb.attempts_remaining).to eq(3)
    end

    it "is not activated upon creation" do
      expect(bomb).not_to be_activated
    end

    it "has not exploded yet" do
      expect(bomb).not_to be_exploded
    end

    subject(:bad_input_bomb) { Bomb.new(23, "21") }

    it "throws exception with invalid parameters" do
      expect { Bomb.new("abc", "123") }.to raise_error
      expect { Bomb.new("2345", false) }.to raise_error
      expect { Bomb.new([3121], "4444") }.to raise_error
    end

    subject(:bomb_with_custom_codes) { Bomb.new("6666", "1357") }

    it "accepts valid custom codes" do
      bomb_with_custom_codes.activate("6666")
      expect(bomb_with_custom_codes).to be_activated
      bomb_with_custom_codes.deactivate("1357")
      expect(bomb_with_custom_codes).not_to be_activated
      expect(bomb_with_custom_codes).not_to be_exploded
    end
  end

  describe "#activate" do
    it "activates when the correct activation code is entered" do
      bomb.activate("1234")
      expect(bomb).to be_activated
    end

    it "does not activate if the activation code is not correct" do
      bomb.activate("1111")
      expect(bomb).not_to be_activated
    end

    it "does nothing if the bomb is already active" do
      2.times do
        bomb.activate("1234")
      end
      expect(bomb).to be_activated
      expect(bomb).not_to be_exploded
      expect(bomb.attempts_remaining).to eq(3)
    end

    it "does not activate if the bomb has exploded" do
      bomb.activate("1234")
      3.times do
        bomb.deactivate("1111")
      end
      bomb.activate("1234")
      expect(bomb).to be_exploded
      expect(bomb).not_to be_activated
    end
  end

  describe "#deactivate" do
    before(:each) do
      bomb.activate("1234")
    end
    it "deactivates the bomb when the correct deactivation code is entered" do
      bomb.deactivate("0000")
      expect(bomb).not_to be_activated
      expect(bomb).not_to be_exploded
    end

    it "does not explode after two incorrect deactivation attempts" do
      2.times do
        bomb.deactivate("4444")
        expect(bomb).to be_activated
        expect(bomb).not_to be_exploded
      end
    end

    it "explodes after three incorrect deactivation attempts" do
      3.times do
        bomb.deactivate("4444")
      end
      expect(bomb).to be_exploded
      expect(bomb.attempts_remaining).to eq(0)
    end

    it "does nothing after exploding" do
      4.times do
        bomb.deactivate("4444")
      end
      bomb.activate("1234")
      expect(bomb).not_to be_activated
      expect(bomb).to be_exploded
      expect(bomb.attempts_remaining).to eq(0)
    end
  end

  describe "#exploded" do
    it "shows that the bomb has not exploded upon boot" do
      expect(bomb).not_to be_exploded
    end

    it "shows that the bomb has not exploded after activation" do
      bomb.activate("1234")
      expect(bomb).not_to be_exploded
    end

    it "does not explode after one or two incorrect deactivation attempts" do
      bomb.activate("1234")
      2.times do
        bomb.deactivate("4444")
        expect(bomb).not_to be_exploded
      end
    end

    it "explodes after three incorrect deactivation attempts" do
      bomb.activate("1234")
      3.times do
        bomb.deactivate("4444")
      end
      expect(bomb).to be_exploded
    end
  end
end
