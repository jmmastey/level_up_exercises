require_relative "../cohort_analyzer"
require_relative "../file_parser"
require_relative "../errors"

describe CohortAnalyzer do
  let(:cohort) { FileParser.parse_data("specs/sample-full-test.json") }
  let(:analysis) { CohortAnalyzer.new(cohort["A"], cohort["B"]) }

  context "#attempts" do
    it "should return total attempts for each dataset of the cohort" do
      expect(analysis.attempts).to eq(A: 100, B: 24)
    end
  end

  context "#successes" do
    it "should return total successful results for each dataset of the cohort" do
      expect(analysis.successes).to eq(A: 50, B: 24)
    end
  end

  context "#conversion_rates" do
    it "should return the conversion rate of success for each dataset of the cohort" do
      expect(analysis.conversion_rates).to eq(A: 50.0, B: 100.0)
    end
  end

  context "#confidence_intervals" do
    it "should return the confidence intervals for each dataset of the cohort" do
      expect(analysis.confidence_intervals).to eq(A: [0.40200180142078257, 0.5979981985792174], B: [1.0, 1.0])
    end
  end

  context "#chi_square_confidence" do
    it "should return the CHI Square of the cohort" do
      expect(analysis.chi_square_confidence).to eq(3.7764319528123202)
    end
  end
end
