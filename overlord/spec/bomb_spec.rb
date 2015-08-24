require_relative '../bomb'

describe Bomb do
  before(:each) do
    @default_activation_code = "1234"
    @default_deactivation_code = "0000"
    @bomb = Bomb.new
  end

  describe "#initialize" do
    it "should return a Bomb object with the state set to OFF" do
      expect(@bomb).to be_a(Bomb)
      expect(@bomb.state).to eq(0)
    end
  end

  describe "#boot_up" do
    context "boot up bomb without supplying activation/deactivation codes" do
      before(:each) do
        @bomb.boot_up
      end

      it "should boot up with default codes" do
        expect(@bomb.activation_code).to eq(@default_activation_code)
        expect(@bomb.deactivation_code).to eq(@default_deactivation_code)
      end

      it "should set the Bomb's state to ON" do
        expect(@bomb.state).to eq(1)
      end
    end

    context "boot up bomb with custom activation and deactivation codes supplied" do
      before(:each) do
        @activation_code = "2345"
        @deactivation_code = "1111"
        @bomb.boot_up(@activation_code, @deactivation_code)
      end

      it "should boot up with supplied codes" do
        expect(@bomb.activation_code).to eq(@activation_code)
        expect(@bomb.deactivation_code).to eq(@deactivation_code)
      end

      it "should set the Bomb's state to ON" do
        expect(@bomb.state).to eq(1)
      end
    end

    context "boot up bomb with invalid activation and deactivation codes supplied" do
      before(:each) do
        @invalid_code = "asdf"
        @bomb.boot_up(@invalid_code, @invalid_code)
      end

      it "should not set the Bomb's state to ON" do
        expect(@bomb.state).to eq(0)
      end
    end
  end

  describe "#activate" do
    context "attempt to activate bomb before bomb has been booted" do
      before(:each) do
        @bomb.activate("1234")
      end

      it "should not activate bomb" do
        expect(@bomb.state).to_not eq(2)
      end
    end

    context "attempt to activate bomb when bomb is on, and configured with default codes" do
      before(:each) do
        @bomb.boot_up
      end

      it "should set the Bomb's state to ACTIVATED when correct code is supplied" do
        @bomb.activate(@default_activation_code)
        expect(@bomb.state).to eq(2)
      end

      it "should not set the Bomb's state to ACTIVATED when incorrect code is supplied" do
        @bomb.activate("asdf")
        expect(@bomb.state).to_not eq(2)
      end
    end

    context "attempt to activate bomb when bomb is on, and configured with custom codes" do
      before(:each) do
        @activation_code = "2345"
        @deactivation_code = "1111"
        @bomb.boot_up(@activation_code, @deactivation_code)
      end

      it "should set the Bomb's state to ACTIVATED when correct code is supplied" do
        @bomb.activate(@activation_code)
        expect(@bomb.state).to eq(2)
      end

      it "should not set the Bomb's state to ACTIVATED when incorrect code is supplied" do
        @bomb.activate("asdf")
        expect(@bomb.state).to_not eq(2)
      end
    end
  end

  describe "#deactivate" do
    context "attempt to deactivate before bomb has been booted" do
      before(:each) do
        @bomb.deactivate(@default_deactivation_code)
      end

      it "should not activate or deactivate the bomb, and bomb should be off" do
        expect(@bomb.state).to_not eq(2)
        expect(@bomb.state).to_not eq(3)
      end
    end

    context "attempt to deactivate before bomb has been activated" do
      before(:each) do
        @bomb.boot_up
        @bomb.deactivate(@default_deactivation_code)
      end

      it "should not activate or deactivate the bomb" do
        expect(@bomb.state).to_not eq(2)
        expect(@bomb.state).to_not eq(3)
      end
    end

    context "attempt to deactivate when bomb has been activated and configured with default codes" do
      before(:each) do
        @bomb.boot_up
        @bomb.activate(@default_activation_code)
      end

      it "should set the Bomb's state to DEACTIVATED when correct code is supplied" do
        @bomb.deactivate(@default_deactivation_code)
        expect(@bomb.state).to eq(3)
      end

      it "should not set the Bomb's state to DEACTIVATED when incorrect code is supplied" do
        @bomb.deactivate("asdf")
        expect(@bomb.state).to_not eq(3)
      end

      it "should increment deactivation attempts when incorrect code is supplied" do
        deactivation_attempts = @bomb.deactivation_attempts
        @bomb.deactivate("asdf")
        expect(@bomb.deactivation_attempts).to eq(deactivation_attempts + 1)
      end

      it "should destroy the bomb after 3 deactivation_attempts" do
        3.times { @bomb.deactivate("asdf") }
        expect(@bomb.state).to eq(4)
      end
    end

    context "attempt to deactivate when bomb has been activated and configured with custom codes" do
      before(:each) do
        @activation_code = "2345"
        @deactivation_code = "1111"
        @bomb.boot_up(@activation_code, @deactivation_code)
        @bomb.activate(@activation_code)
      end

      it "should set the Bomb's state to DEACTIVATED when correct code is supplied" do
        @bomb.deactivate(@deactivation_code)
        expect(@bomb.state).to eq(3)
      end

      it "should not set the Bomb's state to DEACTIVATED when incorrect code is supplied" do
        @bomb.deactivate("asdf")
        expect(@bomb.state).to_not eq(3)
      end

      it "should increment deactivation attempts when incorrect code is supplied" do
        deactivation_attempts = @bomb.deactivation_attempts
        @bomb.deactivate("asdf")
        expect(@bomb.deactivation_attempts).to eq(deactivation_attempts + 1)
      end

      it "should destroy the bomb after 3 deactivation_attempts" do
        3.times { @bomb.deactivate("asdf") }
        expect(@bomb.state).to eq(4)
      end
    end
  end

  describe "#detonate" do
    before(:each) do
      @bomb.detonate
    end

    it "should set the Bomb's state to DESTROYED" do
      expect(@bomb.state).to eq(4)
    end
  end

  describe "#on?" do
    context "bomb has been turned on" do
      before(:each) do
        @bomb.boot_up
      end

      it "should return true; the Bomb's state is ON" do
        expect(@bomb.on?).to eq(true)
      end
    end

    context "bomb has not been turned on" do
      before(:each) do
      end

      it "should return false; the Bomb's state is not ON" do
        expect(@bomb.on?).to eq(false)
      end
    end
  end

  describe "#off?" do
    context "bomb has been turned on" do
      before(:each) do
        @bomb.boot_up
      end

      it "should return false; the Bomb's state is OFF" do
        expect(@bomb.off?).to eq(false)
      end
    end

    context "bomb has not been turned on" do
      before(:each) do
      end

      it "should return true; the bomb's state is OFF" do
        expect(@bomb.off?).to eq(true)
      end
    end
  end

  describe "#activated?" do
    context "bomb has been activated" do
      before(:each) do
        @bomb.boot_up
        @bomb.activate(@default_activation_code)
      end

      it "should return true, Bomb's state is ACTIVATED" do
        expect(@bomb.activated?).to eq(true)
      end
    end

    context "bomb has not been activated" do
      before(:each) do
        @bomb.boot_up
      end

      it "should return false, Bomb's state is not ACTIVATED" do
        expect(@bomb.activated?).to eq(false)
      end
    end
  end

  describe "#deactivated?" do
    context "bomb has been deactivated" do
      before(:each) do
        @bomb.boot_up
        @bomb.activate(@default_activation_code)
        @bomb.deactivate(@default_deactivation_code)
      end

      it "should return true, Bomb's state is DEACTIVATED" do
        expect(@bomb.deactivated?).to eq(true)
      end
    end

    context "bomb has not been deactivated" do
      before(:each) do
        @bomb.boot_up
        @bomb.activate(@default_activation_code)
      end

      it "should return false, Bomb's state is not DEACTIVATED" do
        expect(@bomb.deactivated?).to eq(false)
      end
    end
  end

  describe "#destroyed?" do
    context "bomb has been destroyed" do
      before(:each) do
        @bomb.boot_up
        @bomb.activate(@default_activation_code)
        @bomb.detonate
      end

      it "should return true, Bomb's state is DESTROYED" do
        expect(@bomb.destroyed?).to eq(true)
      end
    end

    context "bomb has not been destroyed" do
      before(:each) do
        @bomb.boot_up
        @bomb.activate(@default_activation_code)
      end

      it "should return false, Bomb's state is not DESTROYED" do
        expect(@bomb.destroyed?).to eq(false)
      end
    end
  end
end
