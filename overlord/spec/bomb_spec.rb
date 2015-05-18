require './bomb.rb'

VALID_ACT_CODE = "2468"
VALID_DEACT_CODE = "1357"
INVALID_ACT_CODE = "abcd"
INVALID_DEACT_CODE = "hello"
TIME_REMAINING = 10

describe Bomb do
  let(:newbomb_valid) { Bomb.new(VALID_ACT_CODE, VALID_DEACT_CODE) }
  let(:newbomb_invalid) { Bomb.new(INVALID_ACT_CODE, INVALID_DEACT_CODE) }

  it "is in an inactive state before start_bomb is called" do
    expect(newbomb_valid.state).to eql(:inactive)
  end

  it "can become active by calling the start_bomb function" do
    newbomb_valid.attempt_activation(VALID_ACT_CODE)
    expect(newbomb_valid.state).to eql(:active)
  end

  it "can be deactivated using the deactivation code" do
    newbomb_valid.attempt_activation(VALID_ACT_CODE)
    newbomb_valid.attempt_deactivation(VALID_DEACT_CODE)
    expect(newbomb_valid.state).to eql(:inactive)
  end

  it "can be restarted after successful deactivation" do
    newbomb_valid.attempt_activation(VALID_ACT_CODE)
    newbomb_valid.attempt_deactivation(VALID_DEACT_CODE)
    newbomb_valid.attempt_activation(VALID_ACT_CODE)
    expect(newbomb_valid.state).to eql(:active)
  end

  it "explodes after #{TIME_REMAINING} seconds" do
    newbomb_valid.attempt_activation(VALID_ACT_CODE)
    sleep(TIME_REMAINING)
    newbomb_valid.update_remaining_time
    expect(newbomb_valid.state).to eql(:exploded)
  end

  it "complains when the activation code is not four digits" do
    expect { Bomb.new(INVALID_ACT_CODE, VALID_DEACT_CODE) }.to raise_error(BombCodeError)
  end
end
