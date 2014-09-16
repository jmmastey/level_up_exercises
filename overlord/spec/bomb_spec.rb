require "rspec"

describe Bomb do
  it "initializes with an activation code and deactivation code" do
    activation_code = 2211
    deactivation_code = 1122
    bomb = Bomb.new(activation_code, deactivation_code)
    expect(bomb.activation_code).to eq(activation_code)
    expect(bomb.deactivation_code).to eq(deactivation_code)
  end

  it "defaults activation/deactivation codes to 1234 and 0000 if none are given" do
    bomb = Bomb.new
    expect(bomb.activation_code).to eq(1234)
    expect(bomb.deactivation_code).to eq(0000)
  end

  it "initializes with wires intact" do
    bomb = Bomb.new
    expect(bomb.wires_intact?).to be true
  end

  it "initializes in an inactive state" do
    bomb = Bomb.new
    expect(bomb).to be_inactive
  end

  describe "#active?" do
    it "returns true when bomb is in an active state" do
      bomb = Bomb.new
      bomb.enter_code("1234")
      expect(bomb).to be_active
    end

    it "returns false when bomb is in any other state" do
      bomb = Bomb.new
      expect(bomb).not_to be_active

      bomb.enter_code("1234")

      bomb.explode
      expect(bomb).not_to be_active
    end
  end

  describe "#enter_code" do
    it "allows user to enter a 4-digit code" do
      bomb = Bomb.new
      bomb.enter_code("1234")
    end

    it "does nothing when nil or empty string is passed in" do
      bomb = Bomb.new
      bomb.enter_code(nil)
      bomb.enter_code("")
    end

    it "throws an exception when a code in an invalid format is entered" do
      bomb = Bomb.new
      expect { bomb.enter_code("DOGG") }.to raise_error(ArgumentError)
      expect { bomb.enter_code("23") }.to raise_error(ArgumentError)
    end

    it "returns the bomb if no exception was raised" do
      bomb = Bomb.new
      expect(bomb.enter_code("1222")).to be_a?(Bomb)
    end

    context "when inactive" do
      it "will activate when given an activation code" do
        bomb = Bomb.new
        bomb.enter_code("1234")
        expect(bomb).to be_active
      end
    end

    context "when active" do
      let(:bomb) do
        Bomb.new.enter_code("1234")
      end

      it "will deactivate when given a deactivation code" do
        bomb.enter_code("0000")
        expect(bomb).to be_inactive
      end

      it "will detonate after being given three wrong codes" do
        3.times do
          expect(bomb).to be_active
          bomb.enter_code("5678")
        end

        expect(bomb).to be_exploded
      end

      context "if no invalid codes have been entered" do
        it "will not count activation codes as invalid codes" do
          expect(bomb.remaining_deactivation_attempts).to eq(3)
          bomb.enter_code("1234")
          expect(bomb.remaining_deactivation_attempts).to eq(3)
        end
      end
    end
  end

  describe "#exploded?" do
    it "returns true when bomb has exploded" do
      bomb = Bomb.new
      bomb.enter_code("1234")

      bomb.explode
      expect(bomb).to be_exploded
    end

    it "returns false when bomb is intact" do
      bomb = Bomb.new
      expect(bomb).not_to be_exploded

      bomb.enter_code("1234")
      expect(bomb).not_to be_exploded
    end
  end

  describe "#inactive?" do
    it "returns true when bomb is in an inactive state" do
      bomb = Bomb.new
      expect(bomb).to be_inactive
    end

    it "returns false when bomb is in any other state" do
      bomb = Bomb.new
      bomb.enter_code("1234")

      expect(bomb).not_to be_inactive

      bomb.explode
      expect(bomb).not_to be_inactive
    end
  end

  describe "#message" do
    it 'reports "Booted" when bomb is first booted' do
      bomb = Bomb.new
      expect(bomb.message).to eq("Booted")
    end

    it 'reports "Invalid Code" when bomb is given an invalid code' do
      bomb = Bomb.new
      bomb.enter_code("5777")
      expect(bomb.message).to eq("Invalid Code")
    end
  end

  describe "#remaining_deactivation_attempts" do
    it "reports the number of remaining allowed deactivation attempts" do
      bomb = Bomb.new
      expect(bomb.remaining_deactivation_attempts).to be > 0
    end

    it "starts at 3 allowed attempts" do
      bomb = Bomb.new
      expect(bomb.remaining_deactivation_attempts).to eq(3)
    end

    it "decrements whenever an invalid code is entered when the bomb is active" do
      bomb = Bomb.new
      bomb.enter_code("1234")
      expect(bomb.remaining_deactivation_attempts).to eq(3)
      bomb.enter_code("5678")
      expect(bomb.remaining_deactivation_attempts).to eq(2)
      bomb.enter_code("5678")
      expect(bomb.remaining_deactivation_attempts).to eq(1)
    end

    it "resets when the bomb is deactivated" do
      bomb = Bomb.new
      bomb.enter_code("1234")
      bomb.enter_code("5678")
      expect(bomb.remaining_deactivation_attempts).to eq(2)

      bomb.enter_code("0000")
      expect(bomb).to be_inactive
      expect(bomb.remaining_deactivation_attempts).to eq(3)
    end
  end
end
