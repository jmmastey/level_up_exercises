require "active_support/time"

require_relative "../src/bomb_timer"

describe BombTimer do
  let(:not_exploded) { "not exploded!" }
  let(:exploded) { "exploded!" }

  let(:explode) do
    ->() { not_exploded.replace(exploded) }
  end

  let(:now) { Time.now }

  context "upon default time" do
    let(:timer) do
      timer = BombTimer.new
      timer.on_times_up(explode)
      timer
    end

    it "should blow up after 30 seconds" do
      expect(Time).to receive(:now).and_return(now)
      timer.start
      expect(Time).to receive(:now).and_return(now + 30.seconds)
      sleep(1)
      expect(not_exploded).to eq(exploded)
    end
  end

  context "upon starting and stop" do
    let(:timer) do
      timer = BombTimer.new
      # time stuff
      timer.start
      # time stuff again
      timer.stop
      timer
    end

    it "should only have the elasped time recorded" do
      expect(timer.elapsed_seconds).to eq(10)
    end
  end

  context "upon starting and stop and resetting" do
    let(:timer) do
      timer = BombTimer.new
      # time stuff
      timer.start
      # time stuff again
      timer.stop
      timer.reset
      timer
    end

    it "should have no elapsed time" do
      expect(timer.elapsed_seconds).to eq(0)
    end
  end

  context "upon resetting with five seconds" do
    let(:timer) do
      timer = BombTimer.new
      timer.reset(5)
      timer
    end

    it "it should take five seconds" do
      # time stuff
      timer.start
      # time stuff
      expect(not_exploded).to eq(exploded)
    end
  end
end
