require_relative '../bomb'

describe Bomb do
  context "activate_deactivate methods" do
    let(:bomb) { Bomb.new }

    it "allows activate to be used instead of send_code when inactive" do
      bomb.boot
      expect(bomb.status).to eq(:inactive)
      bomb.activate("1234")
      expect(bomb.status).to eq(:active)
    end

    it "doesn't allow activate to be used when active" do
      bomb.boot
      bomb.activate("1234")
      expect(bomb.status).to eq(:active)
      expect { bomb.activate("0000") }.to raise_error(StandardError)
    end

    it "allows deactivate to be used when active" do
      bomb.boot
      bomb.activate("1234")
      expect(bomb.status).to eq(:active)
      bomb.deactivate("0000")
      expect(bomb.status).to eq(:inactive)
    end

    it "doesn't allow deactivate to be used when inactive" do
      bomb.boot
      expect { bomb.deactivate("0000") }.to raise_error(StandardError)
    end

    it "doesn't allow activate or deactivate when off" do
      expect { bomb.activate("1234") }.to raise_error(StandardError)
      expect { bomb.deactivate("0000") }.to raise_error(StandardError)
    end
  end
end
