require_relative 'json_loader'
require_relative 'dataset'

describe "BadDataset" do
  let(:json) { JSONLoader.new('test_bad_data.json') }
  subject(:dataset) { Dataset.new(json.fetch_data) }

  context "percentage of conversion" do
    it { expect(dataset.percentage_of_conversion('A').round(4)).to eq(0.5) }
    it { expect(dataset.percentage_of_conversion('B').round(4)).to eq(0.5) }
  end

  context "calculate standard error" do
    it { expect(dataset.calculate_standard_error('A').round(4)).to eq(0.693) }
    it { expect(dataset.calculate_standard_error('B').round(4)).to eq(0.693) }
  end

  context "calculate chi-square probability" do
    it "raises Insufficient Data Error" do
      expect { dataset.calculate_probability.round(4) }.to raise_error { |error|
        expect(error).to be_a(ABAnalyzer::InsufficientDataError)
      }
    end
  end

  context "cohort percentages" do
    it { expect(dataset.cohort_percentages.first).to eq(["A", 0.5]) }
  end

  context "show winner" do
    it "raises Insufficient Data Error" do
      expect { dataset.show_winner }.to raise_error { |error|
        expect(error).to be_a(ABAnalyzer::InsufficientDataError)
      }
    end
  end
end

describe "WinnerADataset" do
  let(:json) { JSONLoader.new('test_winner_a_data.json') }
  subject(:dataset) { Dataset.new(json.fetch_data) }

  context "percentage of conversion" do
    it { expect(dataset.percentage_of_conversion('A').round(4)).to eq(0.6667) }
    it { expect(dataset.percentage_of_conversion('B').round(4)).to eq(0.3077) }
  end

  context "calculate standard error" do
    it { expect(dataset.calculate_standard_error('A').round(4)).to eq(0.2178) }
    it { expect(dataset.calculate_standard_error('B').round(4)).to eq(0.2509) }
  end

  context "calculate chi-square probability" do
    it { expect(dataset.calculate_probability.round(4)).to eq(0.0484) }
  end

  context "cohort percentages" do
    let(:first_cohort_percent) { dataset.cohort_percentages.first }
    it { expect(first_cohort_percent).to eq(["B", 0.3076923076923077]) }
  end

  context "show winner" do
    it { expect(dataset.show_winner).to eq('Cohort A is the winner') }
  end
end

describe "WinnerBDataset" do
  let(:json) { JSONLoader.new('test_winner_b_data.json') }
  subject(:dataset) { Dataset.new(json.fetch_data) }

  context "percentage of conversion" do
    it { expect(dataset.percentage_of_conversion('A').round(4)).to eq(0.3077) }
    it { expect(dataset.percentage_of_conversion('B').round(4)).to eq(0.6667) }
  end

  context "calculate standard error" do
    it { expect(dataset.calculate_standard_error('A').round(4)).to eq(0.2509) }
    it { expect(dataset.calculate_standard_error('B').round(4)).to eq(0.2178) }
  end

  context "calculate chi-square probability" do
    it { expect(dataset.calculate_probability.round(4)).to eq(0.0484) }
  end

  context "cohort percentages" do
    let(:first_cohort_percent) { dataset.cohort_percentages.first }
    it { expect(first_cohort_percent).to eq(["A", 0.3076923076923077]) }
  end

  context "show winner" do
    it { expect(dataset.show_winner).to eq('Cohort B is the winner') }
  end
end
