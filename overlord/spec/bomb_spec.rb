require 'spec_helper'

describe Bomb do
  subject(:bomb) { Bomb.new }
  
  describe "#new" do
    it "is not booted upon creation" do
      expect(bomb).to be_unbooted
    end

    it "is initialized with 3 deactivation attempts" do
      expect(bomb.attempts_remaining).to eq(3)
    end
  end

  describe "#boot" do 
    context "with no codes specified" do
      before(:each) do
        bomb.boot
      end

      it "boots the bomb" do
        expect(bomb).to be_deactivated
      end

      it "defaults to 1234 activation code" do
        bomb.activate("1234")
        expect(bomb).to be_activated
      end

      it "defaults to 0000 deactivation code" do
        bomb.activate("1234")
        bomb.deactivate("0000")
        expect(bomb).to be_deactivated
      end

      it "has no effect after being called once" do
        bomb.boot
        expect(bomb).to be_deactivated
      end
    end

    context "with valid custom codes" do
      before(:each) do
        bomb.boot("1111","2222")
      end

      it "boots the bomb" do
        expect(bomb).to be_deactivated
      end

      it "sets the activation code to 1111" do
        bomb.activate("1111")
        expect(bomb).to be_activated
      end

      it "sets the deactivation code to 2222" do
        bomb.activate("1111")
        bomb.deactivate("2222")
        expect(bomb).to be_deactivated
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
      it "activates when default activation code is entered" do
        puts bomb.activate("1234")
        p bomb.activate("1234")
        expect(bomb).to be_activated
      end

      it "does not activate if the activation code is not correct" do
        bomb.activate("1111")
        expect(bomb).to be_deactivated
      end

      it "does nothing if the bomb is already active" do
        2.times do
          bomb.activate("1234")
          bomb.activate("1234")
        end
        expect(bomb).to be_activated
        expect(bomb.attempts_remaining).to eq(3)
      end

      it "does not activate if the bomb has exploded" do
        bomb.activate("1234")
        3.times do
          bomb.deactivate("1111")
        end
        bomb.activate("1234")
        expect(bomb).to be_exploded
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
      expect(bomb).to be_deactivated
    end

    it "does not explode after two incorrect deactivation attempts" do
      2.times do
        bomb.deactivate("4444")
        expect(bomb).to be_activated
      end
    end

    it "explodes after three incorrect deactivation attempts" do
      3.times do
        bomb.deactivate("4444")
      end
      expect(bomb).to be_exploded
    end

    it "does nothing after exploding" do
      4.times do
        bomb.deactivate("4444")
      end
      bomb.activate("1234")
      expect(bomb).to be_exploded
      expect(bomb.attempts_remaining).to eq(0)
    end
  end

  describe "#exploded?" do
    before(:each) do
      bomb.boot
      bomb.activate("1234")
    end

    it "shows that the bomb has not exploded after activation" do
      expect(bomb).not_to be_exploded
    end

    it "does not explode after one or two incorrect deactivation attempts" do
      bomb.deactivate("4444")
      expect(bomb).not_to be_exploded
      expect(bomb.attempts_remaining).to eq(2)
      bomb.deactivate("4444")
      expect(bomb).not_to be_exploded
      expect(bomb.attempts_remaining).to eq(1)
    end

    it "explodes after three incorrect deactivation attempts" do
      3.times do
        bomb.deactivate("4444")
      end
      expect(bomb.attempts_remaining).to eq(0)
      expect(bomb).to be_exploded
    end

    it "stays exploded with no attempts remaining after 3 incorrect attempts" do
      3.times do
        bomb.deactivate("4444")
      end
      3.times do
        bomb.deactivate("4444")
        expect(bomb.attempts_remaining).to eq(0)
      end
    end

    it "cannot be booted, activated, or deactivated after exploding" do
      3.times do
        bomb.deactivate("4444")
      end
      bomb.boot
      expect(bomb).to be_exploded
      bomb.activate("1234")
      expect(bomb).to be_exploded
      bomb.deactivate("0000")
      expect(bomb).to be_exploded
    end
  end

  describe "#unbooted?" do
    it "is initialized to an unbooted state" do
      expect(bomb).to be_unbooted
    end

    it "is booted when activated, deactivated, or exploded" do
      bomb.boot
      expect(bomb).not_to be_unbooted
      bomb.activate("1234")
      expect(bomb).not_to be_unbooted
      3.times do
        bomb.deactivate("1111")
      end
      expect(bomb).not_to be_unbooted
    end
  end

  describe "#activated?" do
    it "is "
  end
end
