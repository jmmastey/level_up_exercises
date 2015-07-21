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
    it "should return a Bomb object with the state set to OFF" do
      expect(@bomb).to be_a(Bomb)
      expect(@bomb.state).to eq(0)
    end
  end

  describe "#boot_up" do
    context "no arguments" do
      before(:each) do
        @bomb.boot_up
      end

      it "should boot up with default codes" do
        expect(@bomb.activation_code).to eq("1234")
        expect(@bomb.deactivation_code).to eq("0000")
      end

      it "should set the Bomb's state to ON" do
        expect(@bomb.state).to eq(1)
      end
    end

    context "activation and deactivation codes supplied" do
      before(:each) do
        @bomb.boot_up("2345", "1111")
      end

      it "should boot up with supplied codes" do
        expect(@bomb.activation_code).to eq("2345")
        expect(@bomb.deactivation_code).to eq("1111")
      end

      it "should set the Bomb's state to ON" do
        expect(@bomb.state).to eq(1)
      end
    end
  end

  describe "#activate" do
    before(:each) do
      @activate.call("1234")
    end

    it "should set the Bomb's state to ACTIVATED" do
      expect(@bomb.state).to eq(2)
    end
  end

  describe "#deactivate" do
    before(:each) do
      @deactivate.call("0000")
    end

    it "should set the Bomb's state to DEACTIVATED" do
      expect(@bomb.state).to eq(3)
    end
  end

  describe "#detonate" do
    before(:each) do
      @detonate.call
    end

    it "should set the Bomb's state to DESTROYED" do
      expect(@bomb.state).to eq(4)
    end
  end

  describe "#on?" do
    before(:each) do
      @bomb.boot_up
    end

    it "should check if the Bomb's state to ON" do
      expect(@bomb.on?).to eq(true)
    end
  end

  describe "#off?" do
    before(:each) do
      @bomb.boot_up
    end

    it "should check if the Bomb's state to OFF" do
      expect(@bomb.off?).to eq(false)
    end
  end

  describe "#activated?" do
    before(:each) do
      @activate.call("1234")
    end

    it "should check if the Bomb's state to ACTIVATED" do
      expect(@bomb.activated?).to eq(true)
    end
  end

  describe "#deactivated?" do
    before(:each) do
      @deactivate.call("0000")
    end

    it "should check if the Bomb's state to DEACTIVATED" do
      expect(@bomb.deactivated?).to eq(true)
    end
  end

  describe "#destroyed?" do
    before(:each) do
      @detonate.call
    end

    it "should check if the Bomb's state to DESTROYED" do
      expect(@bomb.destroyed?).to eq(true)
    end
  end
end
