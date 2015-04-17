require_relative "spec_helper.rb"
WRONG_ACTIVATION_CODE = '4321'
WRONG_DEACTIVATION_CODE = '1111'

describe Bomb do
  let(:bomb) { Bomb.new }

  it "should check for valid code" do
    expect(Bomb.valid_code?('1')).to be_falsey
    expect(Bomb.valid_code?('ssad')).to be_falsey
    expect(Bomb.valid_code?('112fd')).to be_falsey
    expect(Bomb.valid_code?('1234')).to be_truthy
    expect(Bomb.valid_code?('123456')).to be_truthy
  end

  it "should be activated with default activation code" do
    bomb.activate(Bomb::DEFAULT_ACTIVATION_CODE)
    expect(bomb.status).to eq(:active)
    expect(bomb.wrong_attempts).to eq(0)
  end

  it "should not be activated with wrong activation code" do
    bomb.activate('4321')
    expect(bomb.status).not_to eq(:active)
  end

  it "should be deactivated with default deactivation code" do
    bomb.activate(Bomb::DEFAULT_ACTIVATION_CODE)
    bomb.deactivate(Bomb::DEFAULT_DEACTIVATION_CODE)
    expect(bomb.status).to eq(:inactive)
  end

  it "should not be deactivated with wrong deactivation code" do
    bomb.activate(Bomb::DEFAULT_ACTIVATION_CODE)
    bomb.deactivate(WRONG_DEACTIVATION_CODE)
    expect(bomb.status).not_to eq(:inactive)
  end

  it "should explode after reaching the wrong attempts limit" do
    bomb.activate(Bomb::DEFAULT_ACTIVATION_CODE)
    Bomb::WRONG_ATTEMPTS_LIMIT.times do
      bomb.deactivate(WRONG_DEACTIVATION_CODE)
    end
    expect(bomb.status).to eq(:boom)
  end

  it "should return remaining attempts after a wrong attempt to deactivate" do
    bomb.activate(Bomb::DEFAULT_ACTIVATION_CODE)
    bomb.deactivate(WRONG_DEACTIVATION_CODE)
    expect(bomb.remaining_attempts).to eq(Bomb::WRONG_ATTEMPTS_LIMIT - 1)
    bomb.deactivate(WRONG_DEACTIVATION_CODE)
    expect(bomb.remaining_attempts).to eq(Bomb::WRONG_ATTEMPTS_LIMIT - 2)
  end
end
