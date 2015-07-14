require_relative '../bomb'

describe Bomb do
  context "timer function check" do
    let(:bomb) { Bomb.new }

    it "has a time of 0:00 when off" do
      expect(bomb.state).to eq(:off)
      expect(bomb.time_left).to eq("0:00")
    end

    it "has a time of 0:00 when inactive" do
      bomb.boot
      expect(bomb.state).to eq(:inactive)
      expect(bomb.time_left).to eq("0:00")
    end

    it "has a time of 0:00 when inactive after being active" do
      bomb.boot
      bomb.enter_code("1234")
      expect(bomb.state).to eq(:active)
      bomb.enter_code("0000")
      expect(bomb.state).to eq(:inactive)
      expect(bomb.time_left).to eq("0:00")
    end

    it "has a time of 2:00 when first activated" do
      bomb.boot
      bomb.enter_code("1234")
      expect(bomb.time_left).to eq("2:00")
    end

    it "shows a time of 0:00 when exploded" do
      bomb.state = :exploded
      expect(bomb.time_left).to eq("0:00")
    end

    it "counts down as time passes" do
      bomb.boot
      bomb.enter_code("1234")
      bomb.timer = Time.now - 10
      expect(bomb.time_left).to eq("1:50")
    end

    it "detenates at 0:00" do
      bomb.boot
      bomb.enter_code("1234")
      bomb.timer = Time.now - 119
      expect(bomb.time_left).to eq("0:01")
      sleep(1)
      expect(bomb.time_left).to eq("0:00")
      expect(bomb.status).to eq(:exploded)
    end

    it "counts down normally" do
      bomb.boot
      bomb.enter_code("1234")
      sleep(3)
      expect(bomb.time_left).to eq("1:57")
    end
  end
end
