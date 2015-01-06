require_relative 'test_helper'

describe Sample do
  let(:sample) { Sample.new(conversion_data_a) }

  describe "#new" do
    it "creates a sample with all conversion data for one sample passed to it" do
      expect(sample.size).to eq(conversion_data_a.length)
    end
  end

  it "should show correct conversions" do
    expect(sample.conversions).to eq(DATA_CONVERSIONS_A)
  end

  it "should show correct non-conversions" do
    expect(sample.non_conversions).to eq(DATA_NON_CONVERSIONS_A)
  end

  it "should have a size equal to conversions plus non-conversions" do
    expect(sample.size).to eq(sample.conversions + sample.non_conversions)
  end

  it "gives the correct confidence interval" do
    class_confidence = sample.confidence_interval(CONFIDENCE)
    check_confidence = ABAnalyzer.confidence_interval(DATA_CONVERSIONS_A, DATA_SIZE, CONFIDENCE)
    expect(class_confidence).to eq(check_confidence)
  end
end