require_relative '../bomb'

describe Bomb do
  context "basic function check" do
    let(:bomb) { Bomb.new }

    it "creates a bomb" do
      expect(bomb).to_not be_nil
    end

    it "starts with default settings" do
      expect(bomb.state).to eq(:off)
      expect(bomb.activation_key).to eq("1234")
      expect(bomb.deactivation_key).to eq("0000")
    end

    it "raises an error if booted when already on" do
      bomb.boot
      expect { bomb.boot }.to raise_error(StandardError)
    end

    it "activates with the standard code" do
      bomb.boot
      expect(bomb.status).to eq(:inactive)
      bomb.enter_code("1234")
      expect(bomb.status).to eq(:active)
    end

    it "deactivates with the standard code" do
      bomb.boot
      expect(bomb.status).to eq(:inactive)
      bomb.enter_code("1234")
      expect(bomb.status).to eq(:active)
      bomb.enter_code("0000")
      expect(bomb.status).to eq(:inactive)
    end

    it "allows one wrong deactivation code" do
      bomb.boot
      bomb.enter_code("1234")
      expect(bomb.status).to eq(:active)
      expect { bomb.enter_code("0001") }.to raise_error(StandardError)
      expect(bomb.status).to eq(:active)
    end

    it "allows two wrong deactivation codes" do
      bomb.boot
      bomb.enter_code("1234")
      expect(bomb.status).to eq(:active)
      expect { bomb.enter_code("0001") }.to raise_error(StandardError)
      expect { bomb.enter_code("0001") }.to raise_error(StandardError)
      expect(bomb.status).to eq(:active)
    end

    it "explodes after three wrong attempts" do
      bomb.boot
      bomb.enter_code("1234")
      expect(bomb.status).to eq(:active)
      expect { bomb.enter_code("0001") }.to raise_error(StandardError)
      expect { bomb.enter_code("0001") }.to raise_error(StandardError)
      expect { bomb.enter_code("0001") }.to raise_error(StandardError)
      expect(bomb.status).to eq(:exploded)
    end

    it "only allows preset states to be the bomb's state" do
      bomb.state = :off
      bomb.state = :inactive
      bomb.state = :active
      bomb.state = :exploded
      expect { bomb.state = :on }.to raise_error(StandardError)
      expect { bomb.state = :detonated }.to raise_error(StandardError)
      expect { bomb.state = :armed }.to raise_error(StandardError)
      expect { bomb.state = :broken }.to raise_error(StandardError)
      expect { bomb.state = :hacked }.to raise_error(StandardError)
    end
  end
end
