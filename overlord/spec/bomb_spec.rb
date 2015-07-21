require_relative '../bomb'

describe Bomb do
  before(:each) do
    @bomb = Bomb.new
  end

  describe "#initialize" do
    it "should return a Bomb object with the state set to OFF" do
      expect(@bomb).to be_a(Bomb)
      expect(@bomb.state).to eq(0)
    end
  end

  describe "#boot_up" do
    it "should set the Bomb's state to ON" do
      @bomb.boot_up
      expect(@bomb.state).to eq(1)
    end
  end

  describe "#activate" do
    it "should set the Bomb's state to ACTIVATED" do
      @bomb.boot_up
      @bomb.activate
      expect(@bomb.state).to eq(2)
    end
  end

  describe "#deactivate" do
    it "should set the Bomb's state to DEACTIVATED" do
      @bomb.boot_up
      @bomb.activate
      @bomb.deactivate
      expect(@bomb.state).to eq(3)
    end
  end

  describe "#detonate" do
    it "should set the Bomb's state to DESTROYED" do
      @bomb.boot_up
      @bomb.activate
      @bomb.detonate
      expect(@bomb.state).to eq(4)
    end
  end

  describe "#on?" do
    it "should check if the Bomb's state to ON" do
      @bomb.boot_up
      expect(@bomb.on?).to eq(true)
    end
  end

  describe "#off?" do
    it "should check if the Bomb's state to OFF" do
      @bomb.boot_up
      expect(@bomb.off?).to eq(false)
    end
  end

  describe "#activated?" do
    it "should check if the Bomb's state to ACTIVATED" do
      @bomb.boot_up
      @bomb.activate
      expect(@bomb.activated?).to eq(true)
    end
  end

  describe "#deactivated?" do
    it "should check if the Bomb's state to DEACTIVATED" do
      @bomb.boot_up
      @bomb.activate
      @bomb.deactivate
      expect(@bomb.deactivated?).to eq(true)
    end
  end

  describe "#destroyed?" do
    it "should check if the Bomb's state to DESTROYED" do
      @bomb.boot_up
      @bomb.activate
      @bomb.detonate
      expect(@bomb.destroyed?).to eq(true)
    end
  end
end