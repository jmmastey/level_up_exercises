require_relative '../bomb'

describe Bomb do
  context "activation and deactivation keys" do
    let(:bomb) { Bomb.new }

    # Defaults Checked in Basic bomb spec

    it "allows activation and deactivation key to change when off" do
      expect(bomb.status).to eq(:off)
      bomb.deactivation_key = "5678"
      expect(bomb.deactivation_key).to eq("5678")
      bomb.activation_key = "0451"
      expect(bomb.activation_key).to eq("0451")
    end

    it "doesn't allow the keys to change after the bomb is booted" do
      bomb.boot
      bomb.state = [:active, :inactive].sample
      expect { bomb.activation_key = "5678" }.to raise_error(StandardError)
      expect { bomb.deactivation_key = "5678" }.to raise_error(StandardError)
    end

    it "allows the keys to be checked when off" do
      expect(bomb.activation_key).to eq("1234")
      expect(bomb.deactivation_key).to eq("0000")
    end

    it "protects the keys after the bomb is booted" do
      bomb.boot
      bomb.state = [:active, :inactive].sample
      expect { bomb.activation_key }.to raise_error(StandardError)
      expect { bomb.deactivation_key }.to raise_error(StandardError)
    end
  end
end
