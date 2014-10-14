require_relative 'json_loader'
require_relative 'dataset'

describe "BadDataset" do
  let(:json) { JSONLoader.new('test_bad_data.json') }
  subject(:dataset) { Dataset.new(json.fetch_data) }

  context "total sample size" do
    it { expect(dataset.total_sample_size).to eq(4) }
  end

  context "calculate chi-square probability" do
    it { expect(dataset.calculate_probability.round(4)).to raise_error }
  end

  context "show winner" do
    it { expect(dataset.show_winner).to raise_error }
  end
end

describe "WinnerADataset" do
  let(:json) { JSONLoader.new('test_winner_a_data.json') }
  subject(:dataset) { Dataset.new(json.fetch_data) }

  context "total sample size" do
    it { expect(dataset.total_sample_size).to eq(31) }
  end

  context "calculate chi-square probability" do
    it { expect(dataset.calculate_probability.round(4)).to eq(0.0484) }
  end

  context "show winner" do
    it { expect(dataset.show_winner).to eq('Cohort A is the winner') }
  end
end

describe "WinnerBDataset" do
  let(:json) { JSONLoader.new('test_winner_b_data.json') }
  subject(:dataset) { Dataset.new(json.fetch_data) }

  context "total sample size" do
    it { expect(dataset.total_sample_size).to eq(31) }
  end

  context "calculate chi-square probability" do
    it { expect(dataset.calculate_probability.round(4)).to eq(0.0484) }
  end

  context "show winner" do
    it { expect(dataset.show_winner).to eq('Cohort B is the winner') }
  end
end
