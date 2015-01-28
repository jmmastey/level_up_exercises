require 'spec_helper'

describe Bomb do
  subject(:bomb) { Bomb.new }
  
  describe "#new" do
    it "is not booted upon creation" do
      expect(bomb).not_to be_booted
    end

    it "is not activated" do
      expect(bomb).not_to be_activated
    end

    it "has not exploded" do
      expect(bomb).not_to be_exploded
    end

    it "is set for 3 deactivation attempts" do
      expect(bomb).not_to be_exploded
    end
  end

  describe "#boot" do 
    context "with no codes specified" do
      before(:each) do
        bomb.boot
      end

      it "boots the bomb" do
        expect(bomb).to be_booted
      end
      it "defaults to 1234 activation code" do
        bomb.activate("1234")
        expect(bomb).to be_activated
      end

      it "defaults to 0000 deactivation code" do
        bomb.activate("1234")
        bomb.deactivate("0000")
        expect(bomb).not_to be_activated
        expect(bomb).not_to be_exploded
      end
    end

    context "with valid custom codes" do
      before(:each) do
        bomb.boot("1111","2222")
      end

      it "boots the bomb" do
        expect(bomb).to be_booted
      end

      it "sets the activation code to 1111" do
        bomb.activate("1111")
        expect(bomb).to be_activated
      end

      it "sets the deactivation code to 2222" do
        bomb.activate("1111")
        bomb.deactivate("2222")
        expect(bomb).not_to be_activated
        expect(bomb).not_to be_exploded
      end
    end

    context "with invalid codes" do
      it "throws exception with invalid codes" do
        expect { bomb.boot("abcd", "123") }.to raise_error
        expect { bomb.boot("2345", false) }.to raise_error
        expect { bomb.boot([3121], "4444") }.to raise_error
      end
    end
  end

  describe "#activate" do
    context "with default codes" do
      before(:each) do
        bomb.boot
      end
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
  end

  describe "#deactivate" do
    before(:each) do
      bomb.boot
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
    before(:each) do
      bomb.boot
    end
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
