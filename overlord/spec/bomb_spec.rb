require 'spec_helper'

describe Bomb do
  before :each do
    @bomb = Bomb.new("2345", "4567")
  end

  context "when deactivated" do
    it { expect(@bomb.state).to eq("Deactivated") }

    it "accepts the default activation code" do
      expect(@bomb.correct_activation_code?("1234")).to be true
    end

    it "accepts the custom activation code" do
      expect(@bomb.correct_activation_code?("2345")).to be true
    end

    it "can be activated" do
      @bomb.activate
      time = Time.now.to_i
      expect(@bomb.state).to eq("Activated")
      expect(@bomb.attempts_remaining).to eq(3)
      expect(@bomb.timer_end).to be <= (time + 125)
    end
  end

  context "when activated" do
    it "can be deactivated" do
      @bomb.activate
      expect(@bomb.state).to eq("Activated")
      @bomb.deactivate
      expect(@bomb.state).to eq("Deactivated")
    end

    it "can be exploded" do
      @bomb.explode
      expect(@bomb.state).to eq("Exploded")
    end

    it "accepts the default deactivation code" do
      expect(@bomb.correct_deactivation_code?("0000")).to be true
    end

    it "accepts the custom deactivation code" do
      expect(@bomb.correct_deactivation_code?("4567")).to be true
    end

    it "correctly decrements incorrect deactivation attempts" do
      expect(@bomb.attempts_remaining).to eq(3)
      @bomb.decrement_attempt
      expect(@bomb.attempts_remaining).to eq(2)
    end
  end
end
