require 'spec_helper'

DEFAULT_ACT_CODE = "1234"
DEFAULT_DEACT_CODE = "0000"

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

      it "boots the bomb into deactivated state" do
        expect(bomb).to be_deactivated
      end

      it "defaults to 1234 activation code" do
        bomb.activate(DEFAULT_ACT_CODE)
        expect(bomb).to be_activated
      end

      it "defaults to 0000 deactivation code" do
        bomb.activate(DEFAULT_ACT_CODE)
        bomb.deactivate(DEFAULT_DEACT_CODE)
        expect(bomb).to be_deactivated
      end

      it "raises exception when bomb is already booted" do
        expect { bomb.boot }.to raise_error
      end

      it "raises exception when bomb is activated" do
        bomb.activate(DEFAULT_ACT_CODE)
        expect { bomb.boot }.to raise_error
      end

      it "raises exception if bomb has exploded" do
        bomb.activate(DEFAULT_ACT_CODE)
        3.times do
          bomb.deactivate("1111")
        end
        expect { bomb.boot }.to raise_error
      end
    end

    context "with valid custom codes" do
      before(:each) do
        bomb.boot("1111", "2222")
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
      it "raises exception with invalid codes" do
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
        bomb.activate(DEFAULT_ACT_CODE)
        expect(bomb).to be_activated
      end

      it "does not activate if the activation code is not correct" do
        bomb.activate("1111")
        expect(bomb).to be_deactivated
      end

      it "can be reactivated after being deactivated" do
        bomb.activate(DEFAULT_ACT_CODE)
        bomb.deactivate(DEFAULT_DEACT_CODE)
        bomb.activate(DEFAULT_ACT_CODE)
        expect(bomb).to be_activated
      end

      it "raises exception if bomb is already active" do
        bomb.activate(DEFAULT_ACT_CODE)
        expect { bomb.activate(DEFAULT_ACT_CODE) }.to raise_error
      end

      it "raises exception if bomb has exploded" do
        bomb.activate(DEFAULT_ACT_CODE)
        3.times do
          bomb.deactivate("1111")
        end
        expect { bomb.activate(DEFAULT_ACT_CODE) }.to raise_error
      end

      it "raises exception if bomb is unbooted" do
        expect { Bomb.new.activate(DEFAULT_ACT_CODE) }.to raise_error
      end
    end
  end

  describe "#deactivate" do
    before(:each) do
      bomb.boot
      bomb.activate(DEFAULT_ACT_CODE)
    end
    it "deactivates the bomb when the correct deactivation code is entered" do
      bomb.deactivate(DEFAULT_DEACT_CODE)
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

    it "raises exception if already deactivated" do
      bomb.deactivate(DEFAULT_DEACT_CODE)
      expect { bomb.deactivate(DEFAULT_DEACT_CODE) }.to raise_error
    end

    it "raises exception if called after exploding" do
      3.times do
        bomb.deactivate("4444")
      end
      expect { bomb.deactivate("4444") }.to raise_error
      expect(bomb).to be_exploded
      expect(bomb.attempts_remaining).to eq(0)
    end

    it "raises exception if called on unbooted bomb" do
      expect { Bomb.new.deactivate(DEFAULT_ACT_CODE) }.to raise_error
    end
  end

  describe "#exploded?" do
    before(:each) do
      bomb.boot
      bomb.activate(DEFAULT_ACT_CODE)
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
  end

  describe "#unbooted?" do
    it "is initialized to an unbooted state" do
      expect(bomb).to be_unbooted
    end

    it "is booted when activated, deactivated, or exploded" do
      bomb.boot
      expect(bomb).not_to be_unbooted
      bomb.activate(DEFAULT_ACT_CODE)
      expect(bomb).not_to be_unbooted
      3.times do
        bomb.deactivate("1111")
      end
      expect(bomb).not_to be_unbooted
    end
  end

  describe "#activated?" do
    it "is activated after calling #activate" do
      bomb.boot
      bomb.activate(DEFAULT_ACT_CODE)
      expect(bomb).to be_activated
    end

    it "is not activated if bomb is in any other state" do
      expect(bomb).not_to be_activated
      bomb.boot
      expect(bomb).not_to be_activated
      bomb.activate(DEFAULT_ACT_CODE)
      bomb.deactivate(DEFAULT_DEACT_CODE)
      expect(bomb).not_to be_activated
      bomb.activate(DEFAULT_ACT_CODE)
      3.times do
        bomb.deactivate("1111")
      end
      expect(bomb).not_to be_activated
    end
  end

  describe "#deactivated" do
    it "is deactivated after booting" do
      bomb.boot
      expect(bomb).to be_deactivated
    end

    it "is deactivated after correct deactivation code is entered" do
      bomb.boot
      bomb.activate(DEFAULT_ACT_CODE)
      bomb.deactivate(DEFAULT_DEACT_CODE)
      expect(bomb).to be_deactivated
    end

    it "is not deactivated in any other state" do
      expect(bomb).not_to be_deactivated
      bomb.boot
      bomb.activate(DEFAULT_ACT_CODE)
      expect(bomb).not_to be_deactivated
      3.times do
        bomb.deactivate("1111")
      end
      expect(bomb).not_to be_deactivated
    end
  end
end
