require './spec/spec_helper.rb'

# The data used in this test is also the same data that is being used in
# the actual app. Now you could argue that this is not a good way to write
# the test and it most definitely is not, but recreating an accurate A/B test
# data is lots of work, please forgive the Svajone. The Svajone did calculate
# everything manually first the regressed it using other data sets (made up ones)
# and the results were cool like ice. - svajone

describe Model::Sample do
  let(:file) { './source_data.json' }
  let(:sample) { Model::Sample.new(file) }

  describe "#CONVERION_RATE_MULTIPLIER" do
    it "has a rate of 1.96" do
      expect(Model::Sample::CONVERSION_RATE_MULTIPLIER).to eq(1.96)
    end
  end

  describe "#DEFAULT_SAMPLE_FILE" do
    it "has a default sample file = ./source_data.json" do
      expect(Model::Sample::DEFAULT_SAMPLE_FILE).to eq('./source_data.json')
    end
  end

  describe "#total_size" do
    it "returns the total size of the sample" do
      # the data used to validate has been verified
      # out side of this test
      expect(sample.total_size).to eq(2892)
    end
  end

  describe "#cohort_size" do
    { "A" => 1349, "B" => 1543 }.each do |cohort, size|
      it "returns the size of cohort: '#{cohort}' == '#{size}'" do
        expect(sample.cohort_size(cohort)).to eq(size)
      end
    end
  end

  describe "#conversions" do
    { "A" => 47, "B" => 79 }.each do |cohort, conversion|
      it "returns the conversion of cohort: '#{cohort}' == '#{conversion}'" do
        expect(sample.cohort_conversions(cohort)).to eq(conversion)
      end
    end
  end

  describe "#non_conversions" do
    { "A" => 1302, "B" => 1464 }.each do |cohort, non_conversion|
      it "returns the non-conversion of cohort: '#{cohort}' == '#{non_conversion}'" do
        expect(sample.cohort_non_conversions(cohort)).to eq(non_conversion)
      end
    end
  end

  describe "#conversion_rate" do
    { "A" => 0.034840622683469234, "B" => 0.05119896305897602 }.each do |cohort, rate|
      it "returns the conversion rate of cohort: '#{cohort}' == '#{rate}" do
        expect(sample.conversion_rate(cohort)).to eq(rate)
      end
    end
  end

  describe "#standard_error" do
    { "A" => 0.004992711789347352, "B" => 0.005610934447982827 }.each do |cohort, error|
      it "returns the standard error for cohort: '#{cohort}' == '#{error}" do
        expect(sample.standard_error(cohort)).to eq(error)
      end
    end
  end

  describe "#error_bars" do
    { "A" => 0.9785715107120809, "B" => 1.0997431518046341}.each do |cohort, error|
      it "returns the error bars for cohort: '#{cohort}' == '#{error}" do
        expect(sample.error_bars(cohort)).to eq(error)
      end
    end
  end

  describe "#calculate_confidence_level" do
    it "calculates the confidence level accurately" do
      level = 0.968435974539406
      expect(sample.calculate_confidence_level).to eq(level)
    end
  end

  describe "#get_cohorts" do
    ["A", "B"].each do |cohort|
      it "has an array with cohort = '#{cohort}' in the sample" do
        expect(sample.get_cohorts).to include(cohort)
      end
    end
  end
end
