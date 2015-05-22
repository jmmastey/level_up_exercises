require './bomb.rb'

ACT_CODE = "2468"
DEACT_CODE = "1357"
WRONG_ACT_CODE = "9999"
WRONG_DEACT_CODE = "0000"
BAD_ACT_CODE = "abcd"
BAD_DEACT_CODE = "hello"
LONG_ACT_CODE = "hellooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo"
TIME_REMAINING = 10

describe Bomb do
  let(:newbomb_valid) { Bomb.new(ACT_CODE, DEACT_CODE) }

  #Booting the bomb
  # bad
  it "complains when a very long (and invalid) activation code is used to boot" do
    expect{ Bomb.new(LONG_ACT_CODE, DEACT_CODE) }.to raise_error(BombCodeError)
  end
  # bad
  it "complains when an activation code with 4 letters is used to boot" do
    expect { Bomb.new(BAD_ACT_CODE, DEACT_CODE) }.to raise_error(BombCodeError)
  end
  # sad?
  it "is created with default codes if none are entered" do
    bomb = Bomb.new("","")
    expect(bomb.activation_code).to eql("1234")
    expect(bomb.deactivation_code).to eql("0000")
  end
  # happy
  it "is created with user chosen activation and deactivation codes" do
    bomb = Bomb.new(ACT_CODE, DEACT_CODE)
    expect(bomb.activation_code).to eql(ACT_CODE)
    expect(bomb.deactivation_code).to eql(DEACT_CODE)
  end

  # Activation
  # happy
  describe "#start_bomb" do
    context "with correct activation code" do
       it "sets the state to :active" do
         newbomb_valid.attempt_activation(ACT_CODE)
         expect(newbomb_valid.state).to eql(:active)
       end
    end
    # sad
    context "with wrong activation code" do
      it "leaves bomb in :inactive state" do
        newbomb_valid.attempt_activation(WRONG_ACT_CODE)
        expect(newbomb_valid.state).to eql(:inactive)
      end
    end
    #bad/sad?
    context "with a very long activation code" do
      it "leaves the bomb in an :inactive state" do
        newbomb_valid.attempt_activation(LONG_ACT_CODE)
       expect(newbomb_valid.state).to eql(:inactive)
      end
    end
  end

  # Deactivation
  # happy
  describe "#stop_bomb" do
    context "with correct deactivation code" do
      it "changes the state to :inactive" do 
        newbomb_valid.attempt_activation(ACT_CODE)
        newbomb_valid.attempt_deactivation(DEACT_CODE)
        expect(newbomb_valid.state).to eql(:inactive)
      end
    end
    # sad
    context "with wrong deactivation code" do
      it "does not deactivate the bomb" do
        newbomb_valid.attempt_activation(ACT_CODE)
        newbomb_valid.attempt_deactivation(WRONG_DEACT_CODE)
        expect(newbomb_valid.state).to eql(:active)
      end
    end
    # sad
    context "with invalid deactivation code" do
      it "does not deactivate the bomb" do
        newbomb_valid.attempt_activation(ACT_CODE)
        newbomb_valid.attempt_deactivation(BAD_DEACT_CODE)
        expect(newbomb_valid.state).to eql(:active)
      end
    end
    #bad
    context "when the bomb is not activated" do
      it "returns an error indicating that the bomb cannot be deactivated" do
        expect(newbomb_valid.attempt_deactivation(DEACT_CODE)).to eql(BombStateError)
      end
    end
  end

  # Reactivate bomb
  # happy
  describe "#restart_bomb" do 
    context "with correct activation code" do 
      it "is restarted (changes state to :active) after deactivation" do
        newbomb_valid.attempt_activation(ACT_CODE)
        newbomb_valid.attempt_deactivation(DEACT_CODE)
        newbomb_valid.attempt_activation(ACT_CODE)
        expect(newbomb_valid.state).to eql(:active)
      end
    end
    # bad
    context "with invalid activation code" do
      it "is not restarted" do
        newbomb_valid.attempt_activation(ACT_CODE)
        newbomb_valid.attempt_deactivation(DEACT_CODE)
        newbomb_valid.attempt_activation(LONG_ACT_CODE)
        expect(newbomb_valid.state).to eql(:inactive)
      end
    end
    # sad
    context "with wrong activation code" do
      it "is not restarted" do
        newbomb_valid.attempt_activation(ACT_CODE)
        newbomb_valid.attempt_deactivation(DEACT_CODE)
        newbomb_valid.attempt_activation(WRONG_ACT_CODE)
        expect(newbomb_valid.state).to eql(:inactive)
      end
    end
    it "retains information indicating that the bomb has been active" do
      newbomb_valid.attempt_activation(ACT_CODE)
      newbomb_valid.attempt_deactivation(DEACT_CODE)
      expect(newbomb_valid.has_been_activated).to eql(true)
    end
  end

  # Bomb explosion
  it "explodes after #{TIME_REMAINING} seconds" do
    newbomb_valid.attempt_activation(ACT_CODE)
    sleep(TIME_REMAINING)
    newbomb_valid.update_remaining_time
    expect(newbomb_valid.state).to eql(:exploded)
  end
end
