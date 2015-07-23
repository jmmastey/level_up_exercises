require_relative '../bomb.rb'

describe Bomb do
  before :each do
    @bomb = Bomb.new
  end

  it "is deactivated" do
    expect(@bomb.state).to eq("Deactivated")
  end

  it "can be activated" do
    @bomb.activate
    time = Time.now.to_i
    expect(@bomb.state).to eq("Activated")
    expect(@bomb.attempts_remaining).to eq(3)
    expect(@bomb.timer_end).to be <= (time + 125)
  end

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

  it "accepts the default activation code" do
    expect(@bomb.correct_activation_code?("1234")).to be true
  end

  it "accepts the default deactivation code" do
    expect(@bomb.correct_deactivation_code?("0000")).to be true
  end

  it "accepts the default activation code" do
    bomb = Bomb.new("4567")
    expect(bomb.correct_activation_code?("4567")).to be true
  end

  it "accepts the default deactivation code" do
    bomb = Bomb.new("2345", "4567")
    expect(bomb.correct_deactivation_code?("4567")).to be true
  end

  it "correctly decrements incorrect deactivation attempts" do
    expect(@bomb.attempts_remaining).to eq(3)
    @bomb.decrement_attempt
    expect(@bomb.attempts_remaining).to eq(2)
  end
end
