require_relative '../bomb'

describe Bomb do
  before(:each) do
    @bomb = Bomb.new
    @activate = lambda do |code|
      @bomb.boot_up
      @bomb.activate(code)
    end
    @deactivate = lambda do |code|
      @activate.call("1234")
      @bomb.deactivate(code)
    end
    @detonate = lambda do
      @activate.call("1234")
      3.times { @bomb.deactivate("9999") }
    end
  end

  describe "#initialize" do
    it "should return a Bomb object with the state set to OFF", happy: true do
      expect(@bomb).to be_a(Bomb)
      expect(@bomb.state).to eq(0)
    end
  end

  describe "#boot_up" do
    context "no arguments" do
      before(:each) do
        @bomb.boot_up
      end

      it "should boot up with default codes", happy: true do
        expect(@bomb.activation_code).to eq("1234")
        expect(@bomb.deactivation_code).to eq("0000")
      end

      it "should set the Bomb's state to ON", happy: true do
        expect(@bomb.state).to eq(1)
      end
    end

    context "activation and deactivation codes supplied" do
      before(:each) do
        @bomb.boot_up("2345", "1111")
      end

      it "should boot up with supplied codes", happy: true do
        expect(@bomb.activation_code).to eq("2345")
        expect(@bomb.deactivation_code).to eq("1111")
      end

      it "should set the Bomb's state to ON", happy: true do
        expect(@bomb.state).to eq(1)
      end
    end

    context "invalid activation and deactivation codes supplied" do
      it "should throw an InvalidCodeError", bad: true do
        expect { @bomb.boot_up("asdf", "asdf") }
          .to raise_error(InvalidCodeError)
      end
    end
  end

  describe "#activate" do
    context "bomb is off" do
      before(:each) do
        @bomb.activate("1234")
      end

      it "should not activate bomb", sad: true do
        expect(@bomb.state).to eq(0)
      end
    end

    context "bomb is on, and correct activation code is supplied" do
      before(:each) do
        @activate.call("1234")
      end

      it "should set the Bomb's state to ACTIVATED", happy: true do
        expect(@bomb.state).to eq(2)
      end
    end

    context "bomb is on, but incorrect activation code is supplied" do
      before(:each) do
        @activate.call("2345")
      end

      it "should not activate bomb", sad: true do
        expect(@bomb.state).to eq(1)
      end
    end
  end

  describe "#deactivate" do
    context "bomb has not been activated" do
      before(:each) do
        @bomb.boot_up
        @bomb.deactivate("0000")
      end

      it "should not activate or deactivate the bomb", sad: true do
        expect(@bomb.state).to eq(1)
      end
    end

    context "bomb has been activated and correct code is supplied" do
      before(:each) do
        @deactivate.call("0000")
      end

      it "should set the Bomb's state to DEACTIVATED", happy: true do
        expect(@bomb.state).to eq(3)
      end
    end

    context "bomb has been activated but incorrect code is supplied" do
      before(:each) do
        @deactivate.call("1111")
      end

      it "should not deactivate the bomb", sad: true do
        expect(@bomb.state).to eq(2)
      end

      it "should increment deactivation attempts", bad: true do
        expect(@bomb.deactivation_attempts).to eq(1)
      end
    end
  end

  describe "#detonate" do
    before(:each) do
      @detonate.call
    end

    it "should set the Bomb's state to DESTROYED", happy: true do
      expect(@bomb.state).to eq(4)
    end
  end

  describe "#on?" do
    context "bomb has been turned on" do
      before(:each) do
        @bomb.boot_up
      end

      it "should return true that the Bomb's state is ON", happy: true do
        expect(@bomb.on?).to eq(true)
      end
    end

    context "bomb has not been turned on" do
      before(:each) do
      end

      it "should return false that the Bomb's state is not ON", sad: true do
        expect(@bomb.on?).to eq(false)
      end
    end
  end

  describe "#off?" do
    context "bomb has been turned on" do
      before(:each) do
        @bomb.boot_up
      end

      it "should return false that the Bomb's state is OFF", sad: true do
        expect(@bomb.off?).to eq(false)
      end
    end

    context "bomb has not been turned on" do
      before(:each) do
      end

      it "should return true that the bomb's state is OFF", happy: true do
        expect(@bomb.off?).to eq(true)
      end
    end
  end

  describe "#activated?" do
    context "bomb has been activated" do
      before(:each) do
        @activate.call("1234")
      end

      it "should return true, Bomb's state is ACTIVATED", happy: true do
        expect(@bomb.activated?).to eq(true)
      end
    end

    context "bomb has not been activated" do
      before(:each) do
        @bomb.boot_up
      end

      it "should return false, Bomb's state is not ACTIVATED", sad: true do
        expect(@bomb.activated?).to eq(false)
      end
    end
  end

  describe "#deactivated?" do
    context "bomb has been deactivated" do
      before(:each) do
        @deactivate.call("0000")
      end

      it "should return true, Bomb's state is DEACTIVATED", happy: true do
        expect(@bomb.deactivated?).to eq(true)
      end
    end

    context "bomb has not been deactivated" do
      before(:each) do
        @activate.call("1234")
      end

      it "should return false, Bomb's state is not DEACTIVATED", sad: true do
        expect(@bomb.deactivated?).to eq(false)
      end
    end
  end

  describe "#destroyed?" do
    context "bomb has been destroyed" do
      before(:each) do
        @detonate.call
      end

      it "should return true, Bomb's state is DESTROYED", happy: true do
        expect(@bomb.destroyed?).to eq(true)
      end
    end

    context "bomb has not been destroyed" do
      before(:each) do
        @activate.call("1234")
      end

      it "should return false, Bomb's state is not DESTROYED", sad: true do
        expect(@bomb.destroyed?).to eq(false)
      end
    end
  end
end
