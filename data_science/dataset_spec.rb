require_relative 'json_loader'
require_relative 'dataset'

describe Dataset do
  subject(:json) { JSONLoader.new('source_data.json') }
  subject(:dataset) { Dataset.new(json.fetch_data) }

  context "total sample size" do
    it { expect(dataset.total_sample_size).to eq(2892) }
  end

  context "total users in group" do
    it { expect(dataset.total_in_group('A')).to eq(1349) }
    it { expect(dataset.total_in_group('B')).to eq(1543) }
  end

  context "number of conversion" do
    it { expect(dataset.number_of_conversions('A')).to eq(47) }
    it { expect(dataset.number_of_conversions('B')).to eq(79) }
  end

  context "percentage of conversion" do
    it { expect(dataset.percentage_of_conversion('A').round(4)).to eq(0.0348) }
    it { expect(dataset.percentage_of_conversion('B').round(4)).to eq(0.0512) }
  end

  context "calculate standard error" do
    it { expect(dataset.calculate_standard_error('A').round(4)).to eq(0.0098) }
    it { expect(dataset.calculate_standard_error('B').round(4)).to eq(0.0110) }
  end

  context "calculate chi-square probability" do
    it { expect(dataset.calculate_probability.round(4)).to eq(0.0316) }
  end
end
