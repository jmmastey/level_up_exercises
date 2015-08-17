require_relative "spec_helper"

describe Timer do
  let(:duration) { 10 }
  subject(:timer) { described_class.new(duration) }

  describe "#new" do
    it "is initialized with a duration in seconds" do
      expect { timer }.not_to raise_error
    end

    context "when duration is negative" do
      let(:duration) { -5 }

      it "raises an ArgumentError" do
        expect { timer }.to raise_error(ArgumentError)
      end
    end
  end

  describe "#seconds_remaining" do
    let(:time) { timer.seconds_remaining }

    it "is the number of seconds until detonation time" do
      expect(time).to be_within(1).of(duration)
    end
  end

  context "when time remains on the timer" do
    it { is_expected.not_to be_expired }
  end

  context "when no time remains on the timer" do
    let(:duration) { 0 }

    it { is_expected.to be_expired }
  end
end
