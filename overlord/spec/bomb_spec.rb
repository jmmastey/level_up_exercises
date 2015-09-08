require 'spec_helper'

describe Bomb do
  before :each do
    @custom_bomb = Bomb.new("2345", "4567")
    @default_bomb = Bomb.new
  end

  context "when deactivated" do
    it "accepts the default activation code" do
      expect(@default_bomb.activate("1234")).to be true
    end

    it "accepts the custom activation code" do
      expect(@custom_bomb.activate("2345")).to be true
    end

    it "can be activated" do
      @default_bomb.activate("1234")
      time = Time.now.to_i
      expect(@default_bomb.state).to eq("Activated")
      expect(@default_bomb.attempts_remaining).to eq(3)
      expect(@default_bomb.timer_end).to be <= (time + 125)
    end
  end

  context "when activated" do
    it "can be deactivated" do
      @default_bomb.activate("1234")
      expect(@default_bomb.state).to eq("Activated")
      @default_bomb.deactivate("0000")
      expect(@bomb.state).to eq("Deactivated")
    end

    it "can be exploded" do
      @bomb.explode
      expect(@bomb.state).to eq("Exploded")
    end

    it "accepts the default deactivation code" do
      expect(@default_bomb.deactivate("0000")).to be true
    end

    it "accepts the custom deactivation code" do
      expect(@custom_bomb.deactivate("4567")).to be true
    end

    it "correctly decrements incorrect deactivation attempts" do
      expect(@bomb.attempts_remaining).to eq(3)
      @bomb.deactivate("2222")
      expect(@bomb.attempts_remaining).to eq(2)
    end

    it "explodes the bomb after 3 invalid deactivation attempts" do
      expect(@bomb.attempts_remaining).to eq(3)
      3.times { @bomb.deactivate("2222") }
      expect(@bomb.state == "Exploded")
    end
  end
end
