require_relative 'json_loader'
require_relative 'dataset'

describe "The Bad Dataset" do
  let(:json) { JSONLoader.new('test_bad_data.json') }
  let(:dataset) { Dataset.new(json.fetch_data) }

  it "has the correct percentage of conversions" do
    expect(dataset.percentage_of_conversion('A').round(4)).to eq(0.5)
    expect(dataset.percentage_of_conversion('B').round(4)).to eq(0.5)
  end

  it "has the correct calculation of the standard error" do
    expect(dataset.calculate_standard_error('A').round(4)).to eq(0.693)
    expect(dataset.calculate_standard_error('B').round(4)).to eq(0.693)
  end

  context "raises an error when calculating the chi-square probability" do
    subject(:probabilities) { dataset.calculate_group_probabilities.round(4) }
    it "raises Insufficient Data Error" do
      expect { subject }.to raise_error { |error|
        expect(error).to be_a(ABAnalyzer::InsufficientDataError)
      }
    end
  end

  context "has the correct cohort percentages" do
    it { expect(dataset.cohort_percentages.first).to eq(["A", 0.5]) }
  end

  context "raises an error when showing the correct winner" do
    it "raises Insufficient Data Error" do
      expect { dataset.show_winner }.to raise_error { |error|
        expect(error).to be_a(ABAnalyzer::InsufficientDataError)
      }
    end
  end
end

describe "The Dataset of Winner A" do
  let(:json) { JSONLoader.new('test_winner_a_data.json') }
  let(:dataset) { Dataset.new(json.fetch_data) }

  it "has the correct percentage of conversion" do
    expect(dataset.percentage_of_conversion('A').round(4)).to eq(0.6667)
    expect(dataset.percentage_of_conversion('B').round(4)).to eq(0.3077)
  end

  it "has the correct calculation of the standard error" do
    expect(dataset.calculate_standard_error('A').round(4)).to eq(0.2178)
    expect(dataset.calculate_standard_error('B').round(4)).to eq(0.2509)
  end

  context "has the correct calculation of the chi-square probability" do
    it { expect(dataset.calculate_group_probabilities.round(4)).to eq(0.0484) }
  end

  context "has the correct cohort percentages" do
    let(:first_cohort_percent) { dataset.cohort_percentages.first }
    it { expect(first_cohort_percent).to eq(["B", 0.3076923076923077]) }
  end

  context "is showing the correct winner" do
    it { expect(dataset.show_winner).to eq('Cohort A is the winner') }
  end
end

describe "The Dataset of Winner B" do
  let(:json) { JSONLoader.new('test_winner_b_data.json') }
  let(:dataset) { Dataset.new(json.fetch_data) }

  it "has the correct percentage of conversion" do
    expect(dataset.percentage_of_conversion('A').round(4)).to eq(0.3077)
    expect(dataset.percentage_of_conversion('B').round(4)).to eq(0.6667)
  end

  it "has the correct calculation of the standard error" do
    expect(dataset.calculate_standard_error('A').round(4)).to eq(0.2509)
    expect(dataset.calculate_standard_error('B').round(4)).to eq(0.2178)
  end

  context "has the correct calculation of the chi-square probability" do
    it { expect(dataset.calculate_group_probabilities.round(4)).to eq(0.0484) }
  end

  context "has the correct cohort percentages" do
    let(:first_cohort_percent) { dataset.cohort_percentages.first }
    it { expect(first_cohort_percent).to eq(["A", 0.3076923076923077]) }
  end

  context "is showing the correct winner" do
    it { expect(dataset.show_winner).to eq('Cohort B is the winner') }
  end
end

describe "The No Clear Winner Dataset" do
  let(:json) { JSONLoader.new('test_no_winner_data.json') }
  let(:dataset) { Dataset.new(json.fetch_data) }

  it "has the correct percentage of conversion" do
    expect(dataset.percentage_of_conversion('A').round(4)).to eq(0.5556)
    expect(dataset.percentage_of_conversion('B').round(4)).to eq(0.3846)
  end

  it "has the correct calculation of the standard error" do
    expect(dataset.calculate_standard_error('A').round(4)).to eq(0.2296)
    expect(dataset.calculate_standard_error('B').round(4)).to eq(0.2645)
  end

  context "has the correct calculation of the chi-square probability" do
    it { expect(dataset.calculate_group_probabilities.round(4)).to eq(0.3473) }
  end

  context "has the correct cohort percentages" do
    let(:first_cohort_percent) { dataset.cohort_percentages.first }
    it { expect(first_cohort_percent).to eq(["B", 0.38461538461538464]) }
  end

  context "is showing the correct winner" do
    it { expect(dataset.show_winner).to eq('No clear winner') }
  end
end
