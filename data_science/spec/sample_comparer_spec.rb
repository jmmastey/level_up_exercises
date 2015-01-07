require_relative 'test_helper'

describe SampleComparer do
  let(:sample_a) { Sample.new(conversion_data_a) }
  let(:sample_b) { Sample.new(conversion_data_b) }
  let(:comparer_same) { SampleComparer.new(sample_a, sample_a) }
  let(:comparer_different) { SampleComparer.new(sample_a, sample_b) }

  it "says an identical data set is not different" do
    expect(comparer_same.different?).to be(false)
  end

  it "says chisquare_p is smaller than #{CONFIDENCE}" do
    expect(comparer_different.chisquare_p).to be < CONFIDENCE
  end

  it "says a different data set is different" do
    expect(comparer_different.different?).to be(true)
  end
end
