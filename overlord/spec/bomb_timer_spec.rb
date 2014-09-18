require "active_support/time"

require_relative "../src/bomb_timer"

describe BombTimer do
  let(:a_millisecond) { 1E-3 }
  let(:now) { Time.now }

  context "upon creation" do
    let(:timer) do
      BombTimer.new
    end

    it "should not be triggered" do
      expect(timer).not_to be_triggered
    end

    it "should not be started" do
      expect(timer).not_to be_started
    end
  end

  context "upon starting the 30 second default time" do
    let(:timer) do
      timer = BombTimer.new
      timer.start
      timer
    end

    it "should be started" do
      expect(timer).to be_started
    end

    it "should raise an error if started again" do
      expect{ timer.start }.to raise_error
    end

    it "should have a deadline set 30 seconds from now" do
      expect(timer.deadline).to be_within(a_millisecond).of(now + 30.seconds)
    end

    it "should trigger after 30 seconds" do
      expect(timer).to receive(:deadline)
        .and_return(1.seconds.ago).at_least(:once)
      expect(timer).to be_triggered
    end

    it "should not countdown when stopped" do
      timer.stop
      remaining = timer.seconds_remaining
      expect(timer.seconds_remaining).to eq(remaining)
      timer.start
      expect(timer.seconds_remaining).not_to eq(remaining)
    end

    it "should be able to be reset with new seconds remaining" do
      expect(timer.seconds_remaining).not_to eq(30.seconds)
      timer.stop
      timer.reset
      expect(timer.seconds_remaining).to eq(30.seconds)
    end
  end

  context "upon starting with 40 seconds" do
    let(:timer) do
      timer = BombTimer.new(40)
      timer.start
      timer
    end

    it "should have a deadline close to 40 seconds from now" do
      expect(timer.deadline).to be_within(a_millisecond).of(now + 40.seconds)
    end

    it "should be exploded after 40 seconds" do
      expect(timer).to receive(:deadline).and_return(1.seconds.ago).at_least(:once)
      expect(timer).to be_triggered
    end

    it "should not be triggered when deadline has not past" do
      expect(timer).to receive(:deadline)
        .and_return(now + 10.seconds).at_least(:once)
      timer.stop
      expect(timer.seconds_remaining).to be_within(a_millisecond).of(10.seconds)
      expect(timer).not_to be_triggered
    end
  end
end
