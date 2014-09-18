require_relative "../lib/timer.rb"

describe Timer do
  let(:timer) { Timer.new(240) }
  let(:negative_timer) { Timer.new(-1) }

  it "initializes with a duration in seconds" do
    expect(timer.duration).to eq(240)
  end

  it "sets start time to current time" do
    expect(timer.start_time).to be_within(10).of(Time.now)
  end

  it "sets end time to duration seconds after the start time" do
    expect(timer.end_time).to eq(timer.start_time + 240)
  end

  it "initializes as active" do
    expect(timer).to be_active
  end

  it "is expired after the duration has elapsed" do
    expect(negative_timer).to be_expired
  end
end
