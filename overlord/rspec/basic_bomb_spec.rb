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
  end
end
