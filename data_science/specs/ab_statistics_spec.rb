require_relative "../ab_statistics"
require_relative "../errors"

describe ABStatistics do
  let(:ab_small_cohort) { DataAnalyzer.new(Dir.getwd.concat("/specs/sample-small-test.json")).parse_data }
  let(:ab_small_stats)  { ABStatistics.new(ab_small_cohort) }

  let(:ab_sample_cohort) { DataAnalyzer.new(Dir.getwd.concat("/specs/sample-full-test.json")).parse_data }
  let(:ab_sample_stats)  { ABStatistics.new(ab_sample_cohort) }

  it "should load JSON dataset to cohort with associated results" do
    expect(ab_small_stats.cohort_data).to eq("A" => [1, 1, 0])
  end

  context "#cohort_sample_size" do
    let(:cohort) { "A" }

    it "should fail if asked for invalid cohort" do
      expect { ab_sample_stats.cohort_sample_size("X") }.to raise_error(MissingCohortError)
    end

    it "should calculate the total sample size of a cohort" do
      expect(ab_sample_stats.cohort_sample_size(cohort)).to be_an(Integer)
      expect(ab_sample_stats.cohort_sample_size(cohort)).to eq(100)
    end
  end

  context "#cohort_sample_success" do
    let(:cohort) { "A" }

    it "should fail if asked for invalid cohort" do
      expect { ab_sample_stats.cohort_sample_success("X") }.to raise_error(MissingCohortError)
    end

    it "should calculate the total successful conversions from a cohort" do
      expect(ab_sample_stats.cohort_sample_success(cohort)).to be_an(Integer)
      expect(ab_sample_stats.cohort_sample_success(cohort)).to eq(50)
    end
  end

  context "#cohort_conversion_rate" do
    let(:cohort) { "A" }

    it "should fail if asked for invalid cohort" do
      expect { ab_sample_stats.cohort_conversion_rate("X") }.to raise_error(MissingCohortError)
    end

    it "should calculate the conversion rate (percent) of a cohort" do
      expect(ab_sample_stats.cohort_conversion_rate(cohort)).to be_a(Float)
      expect(ab_sample_stats.cohort_conversion_rate(cohort)).to eq(50.0)
    end
  end

  context "#cohort_totals" do
    let(:cohort) { "A" }

    it "should fail if asked for invalid cohort" do
      expect { ab_sample_stats.cohort_totals("X") }.to raise_error(MissingCohortError)
    end

    it "should return a hash of success and total sample for a cohort" do
      expect(ab_sample_stats.cohort_totals(cohort)).to be_a(Hash)
      expect(ab_sample_stats.cohort_totals(cohort)).to eq(success: 50, total: 100)
    end
  end

  context "#chi_square_confidence" do
    it "should give confidence level that is better than random... <= 5%" do
      expect(ab_sample_stats.chi_square_confidence).to be <= 5
    end
  end
end
