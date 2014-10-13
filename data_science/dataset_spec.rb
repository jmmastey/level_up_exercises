require_relative 'json_loader'
require_relative 'dataset'

# describe Dataset do
#   let(:json) { JSONLoader.new('source_data.json') }
#   subject(:dataset) { Dataset.new(json.fetch_data) }

#   context "total sample size" do
#     it { expect(dataset.total_sample_size).to eq(2892) }
#   end

#   context "total users in group" do
#     it { expect(dataset.total_in_group('A')).to eq(1349) }
#     it { expect(dataset.total_in_group('B')).to eq(1543) }
#   end

#   context "number of conversion" do
#     it { expect(dataset.number_of_conversions('A')).to eq(47) }
#     it { expect(dataset.number_of_conversions('B')).to eq(79) }
#   end

#   context "percentage of conversion" do
#     it { expect(dataset.percentage_of_conversion('A').round(4)).to eq(0.0348) }
#     it { expect(dataset.percentage_of_conversion('B').round(4)).to eq(0.0512) }
#   end

#   context "calculate standard error" do
#     it { expect(dataset.calculate_standard_error('A').round(4)).to eq(0.0098) }
#     it { expect(dataset.calculate_standard_error('B').round(4)).to eq(0.0110) }
#   end

#   context "calculate chi-square probability" do
#     it { expect(dataset.calculate_probability.round(4)).to eq(0.0316) }
#   end

#   context "show winner" do
#     it { expect(dataset.show_winner).to eq('Cohort B is the winner') }
#   end
# end

# describe "BadDataset" do
#   let(:json) { JSONLoader.new('test_bad_data.json') }
#   subject(:dataset) { Dataset.new(json.fetch_data) }

#   context "total sample size" do
#     it { expect(dataset.total_sample_size).to eq(4) }
#   end

#   context "total users in group" do
#     it { expect(dataset.total_in_group('A')).to eq(2) }
#     it { expect(dataset.total_in_group('B')).to eq(2) }
#   end

#   context "number of conversion" do
#     it { expect(dataset.number_of_conversions('A')).to eq(1) }
#     it { expect(dataset.number_of_conversions('B')).to eq(1) }
#   end

#   context "percentage of conversion" do
#     it { expect(dataset.percentage_of_conversion('A').round(4)).to eq(0.5) }
#     it { expect(dataset.percentage_of_conversion('B').round(4)).to eq(0.5) }
#   end

#   context "calculate standard error" do
#     it { expect(dataset.calculate_standard_error('A').round(4)).to eq(0.693) }
#     it { expect(dataset.calculate_standard_error('B').round(4)).to eq(0.693) }
#   end

#   context "calculate chi-square probability" do
#     it { expect(dataset.calculate_probability.round(4)).to raise_error }
#   end

#   context "show winner" do
#     it { expect(dataset.show_winner).to raise_error(/Insufficient data size/) }
#   end
# end

describe "WinnerADataset" do
  let(:json) { JSONLoader.new('test_winner_a_data.json') }
  subject(:dataset) { Dataset.new(json.fetch_data) }

  context "total sample size" do
    it { expect(dataset.total_sample_size).to eq(31) }
  end

  context "total users in group" do
    it { expect(dataset.total_in_group('A')).to eq(18) }
    it { expect(dataset.total_in_group('B')).to eq(13) }
  end

  context "number of conversion" do
    it { expect(dataset.number_of_conversions('A')).to eq(12) }
    it { expect(dataset.number_of_conversions('B')).to eq(4) }
  end

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

  context "show winner" do
    it { expect(dataset.show_winner).to eq('Cohort A is the winner') }
  end
end
