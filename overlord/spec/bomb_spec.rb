require_relative "../lib/supervillian/bomb"

describe Supervillian::Bomb do

  REGISTERED_ARMING_CODE = "6543"
  REGISTERED_DISARMING_CODE = "8654"
  UNREGISTERED_ARMING_CODE = "7777"
  UNREGISTERED_DISARMING_CODE = "9888"
  TIME_DELAY_S = 1

  def swallow_bomb_error
    yield
  rescue Supervillian::BombError
    # no-op
  end

  let(:unconfigured_bomb) { Supervillian::Bomb.new }

  let(:configured_bomb) do
    configured_bomb = unconfigured_bomb
    configured_bomb.arming_code = REGISTERED_ARMING_CODE
    configured_bomb.disarming_code = REGISTERED_DISARMING_CODE
    configured_bomb
  end

  let(:locked_bomb) do
    locked_bomb = configured_bomb
    locked_bomb.lock
    locked_bomb
  end

  let(:armed_bomb) do
    armed_bomb = locked_bomb
    armed_bomb.delay = 3
    configured_bomb.arm(REGISTERED_ARMING_CODE)
    armed_bomb
  end

  context "when bomb is initially started it" do
    it "is disarmed" do
      expect(unconfigured_bomb.armed).to be_falsey
    end

    it "has default arming code \"1234\"" do
      expect(unconfigured_bomb.arming_code).to eq("1234")
    end

    it "has default disarming code \"0000\"" do
      expect(unconfigured_bomb.disarming_code).to eq("0000")
    end

    it "is unlocked" do
      expect(unconfigured_bomb.locked).to be_falsey
    end
  
    it "accepts a new arming code" do
      expect(configured_bomb.arming_code).to eq(REGISTERED_ARMING_CODE)
    end

    it "accepts a new disarming codeunlocked" do
      expect(configured_bomb.disarming_code).to eq(REGISTERED_DISARMING_CODE)
    end

    it "rejects a non-numeric arming code" do
      expect { unconfigured_bomb.arming_code = "123X" }.to \
        raise_error(Supervillian::WrongActivationCodeError)
    end

    it "rejects a non-numeric disarming code" do
      expect { unconfigured_bomb.disarming_code = "123X" }.to \
        raise_error(Supervillian::WrongActivationCodeError)
    end
  end

  context "when bomb is locked and disarmed it" do
    it "does not accept a new arming code" do
      expect { locked_bomb.arming_code = UNREGISTERED_ARMING_CODE }.to \
        raise_error(Supervillian::OperationDeniedError)
    end

    it "does not accept a new disarming code" do
      expect { locked_bomb.disarming_code = UNREGISTERED_DISARMING_CODE }.to \
        raise_error(Supervillian::OperationDeniedError)
    end

    it "accepts a new detonation time delay" do
      locked_bomb.delay = TIME_DELAY_S
      expect(locked_bomb.delay).to eq(TIME_DELAY_S)
    end

    it "arms using the registered code" do
      expect(armed_bomb.armed).to eq(true)
    end

    it "raises error on attempt to arm with wrong arming code" do
      expect { locked_bomb.arm(UNREGISTERED_ARMING_CODE) }.to \
        raise_error(Supervillian::WrongActivationCodeError)
    end

    it "does not arm using wrong arming code" do
      swallow_bomb_error do
        locked_bomb.arm(UNREGISTERED_DISARMING_CODE)
      end
      expect(locked_bomb.armed).to be_falsey
    end
  end

  context "when bomb is armed it" do
    it "disarms using the registered disarming code" do
      armed_bomb.disarm(REGISTERED_DISARMING_CODE)
      expect(armed_bomb.armed).to be_falsey
    end

    it "raises error disarming with wrong disarming code" do
      expect { armed_bomb.disarm(UNREGISTERED_ARMING_CODE) }.to \
        raise_error(Supervillian::WrongActivationCodeError)
    end

    it "does not disarm using wrong disarming code" do
      swallow_bomb_error do
        armed_bomb.disarm(UNREGISTERED_ARMING_CODE)
      end
      expect(armed_bomb.armed).to be_truthy
    end

    it "raises error changing arming code" do
      expect { armed_bomb.arming_code = UNREGISTERED_ARMING_CODE }.to \
        raise_error(Supervillian::OperationDeniedError)
    end

    it "does not accept a new arming code" do
      swallow_bomb_error do
        armed_bomb.arming_code = UNREGISTERED_ARMING_CODE
      end
      expect(armed_bomb.arming_code).to eq(REGISTERED_ARMING_CODE)
    end

    it "raises error changring disarming code" do
      expect { armed_bomb.disarming_code = UNREGISTERED_DISARMING_CODE }.to \
        raise_error(Supervillian::OperationDeniedError)
    end

    it "does not accept a new disarming code" do
      swallow_bomb_error do
        armed_bomb.disarming_code = UNREGISTERED_DISARMING_CODE
      end
      expect(armed_bomb.disarming_code).to eq(REGISTERED_DISARMING_CODE)
    end

    it "explodes on three failed disarming attempts" do
      3.times do
        swallow_bomb_error do
          armed_bomb.disarm(UNREGISTERED_ARMING_CODE)
        end
      end
      expect(armed_bomb.exploded?).to be_truthy
    end

    it "gives remaining countdown" do
      expectation = armed_bomb.delay - 1
      sleep 1
      expect(armed_bomb.delay_remaining).to be_within(1).of(expectation)
    end

    it "explodes after delay" do
      sleep armed_bomb.delay + 0.10
      expect(armed_bomb.exploded?).to be_truthy
    end
  end
end
