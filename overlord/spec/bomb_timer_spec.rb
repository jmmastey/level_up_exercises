require "active_support/time"

require_relative "../src/bomb_timer"

describe BombTimer do
  let(:now) { Time.now }

  context "upon starting the 30 second default time" do
    let(:now) { Time.now }

    let(:timer) do
      timer = BombTimer.new
      timer.start(now)
      timer
    end

    it "should raise an error if started again" do
      expect{ timer.start(now) }.to raise_error
    end

    it "should trigger after 30 seconds" do
      expect(timer).to be_triggered(now + 30.seconds)
    end
  end

  context "upon setting a 40 seconds" do
    let(:timer) do
      timer = BombTimer.new(40)
      timer.start(now)
      timer
    end

    it "should not be exploded after 30 seconds" do
      expect(timer).not_to be_triggered(now + 30.seconds)
    end

    it "should be exploded after 40 seconds" do
      expect(timer).to be_triggered(now + 40.seconds)
    end
  end

  context "upon starting and checking before time is up" do
    let(:timer) do
      timer = BombTimer.new
      timer.start(now)
      timer
    end

    it "it should not trigger" do
      expect(timer).not_to be_triggered(now + 29.seconds)
    end
  end

  context "upon resetting after 25 seconds and starting again" do
    let(:timer) do
      timer = BombTimer.new
      timer.start(now)
      timer.stop(now + 25.seconds)
      timer.reset(now)
      timer.start(now)
      timer
    end

    it "should not be triggered" do
      expect(timer).not_to be_triggered(now + 25.seconds)
    end
  end

  context "upon starting, stopping before time is up" do
    let(:timer) do
      timer = BombTimer.new
      timer.start(now)
      timer.stop(now + 5.seconds)
      timer
    end

    it "should raise error if trying to stop again" do
      expect{ timer.stop(now) }.to raise_error
    end

    it "it should not be triggered" do
      expect(timer).not_to be_triggered(now + 45.seconds)
    end
  end
end
