require_relative "../lib/supervillian/bomb"

describe Supervillian::Bomb do

  REGISTERED_ARMING_CODE = 6543
  REGISTERED_DISARMING_CODE = 8654
  TIME_DELAY_S = 1
  
  def swallow_bomb_error
    begin
      yield
    rescue Supervillian::BombError
      # no-op
    end
  end

  let(:unconfigured_bomb) do
    unconfigured_bomb = Supervillian::Bomb.new
  end

  let(:configured_bomb) do
    configured_bomb = Supervillian::Bomb.new
    configured_bomb.arming_code = REGISTERED_ARMING_CODE
    configured_bomb.disarming_code = REGISTERED_DISARMING_CODE
    configured_bomb.delay = TIME_DELAY_S
    configured_bomb
  end

  let(:armed_bomb) do
    armed_bomb = configured_bomb
    configured_bomb.arm!(REGISTERED_ARMING_CODE)
    armed_bomb
  end

  it "starts up unarmed" do
    expect(unconfigured_bomb.armed?).not_to be true
  end

  it "starts up with default arming code 1234" do
    expect(unconfigured_bomb.arming_code).to be(1234)
  end

  it "starts up with default disarming code 0000" do
    expect(unconfigured_bomb.disarming_code).to be(0000)
  end

  it "accepts a new arming code when disarmed" do
    expect(configured_bomb.arming_code).to be(REGISTERED_ARMING_CODE)
  end

  it "accepts a new disarming code when disarmed" do
    expect(configured_bomb.disarming_code).to be(REGISTERED_DISARMING_CODE)
  end

  it "accepts a new detonation time delay when disarmed" do
    expect(configured_bomb.delay).to be(TIME_DELAY_S)
  end

  it "arms using the registered code" do
    expect(armed_bomb.armed?).to be(true)
  end

  it "raises an exception on attempt to arm with unregistered arming code" do
    expect { configured_bomb.arm!(REGISTERED_ARMING_CODE + 1234) }.to \
      raise_error(Supervillian::WrongActivationCodeError)
  end

  it "does not arm using an unregistered arming code" do
    swallow_bomb_error do
      configured_bomb.arm!(REGISTERED_DISARMING_CODE + 1234)
    end
    expect(configured_bomb.armed?).to be(false)
  end

  it "disarms using the registered disarming code" do
    armed_bomb.disarm!(REGISTERED_DISARMING_CODE)
    expect(armed_bomb.armed?).to be(false)
  end

  it "raises an exception disarming with an unregistered disarming code" do
    expect { armed_bomb.disarm!(REGISTERED_ARMING_CODE - 1234) }.to \
      raise_error(Supervillian::WrongActivationCodeError)
  end

  it "does not disarm using an unregistered disarming code" do
    swallow_bomb_error do
      armed_bomb.disarm!(REGISTERED_ARMING_CODE - 1234)
    end
    expect(armed_bomb.armed?).to be(true)
  end

  it "raises an exception on attempt to change arming code when armed" do
    expect { armed_bomb.arming_code = REGISTERED_ARMING_CODE - 1234 }.to \
      raise_error(Supervillian::OperationDeniedError)
  end

  it "does not accept a new arming code when armed" do
    swallow_bomb_error do
      armed_bomb.arming_code = REGISTERED_ARMING_CODE - 1234
    end
    expect(armed_bomb.arming_code).to be(REGISTERED_ARMING_CODE)
  end

  it "raises an expection on attempt to change disarming code when armed" do
    expect { armed_bomb.disarming_code = REGISTERED_DISARMING_CODE - 1234 }.to \
      raise_error(Supervillian::OperationDeniedError)
  end

  it "does not accept a new disarming code when disarmed" do
    swallow_bomb_error do
      armed_bomb.disarming_code = REGISTERED_DISARMING_CODE - 1234
    end
    expect(armed_bomb.disarming_code).to be(REGISTERED_DISARMING_CODE)
  end
  
  it "explodes on three failed disarming attempts" do
    3.times do
      swallow_bomb_error do
        armed_bomb.disarm!(REGISTERED_ARMING_CODE - 1234)
      end
    end
    expect(armed_bomb.exploded?).to be(true)
  end

  it "explodes after delay" do
    sleep armed_bomb.delay + 0.10
    expect(armed_bomb.exploded?).to be(true)
  end
end
