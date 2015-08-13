require_relative '../data_statistics'

describe DataStatistics do
  let(:filename) { 'test.json' }
  let(:data_stat) { DataStatistics.new(filename) }

  describe "#convert_data_to_hash" do
    it "assigns the chi square values to the relevant cohort group" do
      values = {}
      values["A"] = { "A" => { converted: 5, not_con: 6 } }
      data_stat.convert_data_to_hash
      expect(data_stat.values).to eq(values["A"])
    end
  end

  describe "#chi_square" do
    it "gets the chi_square value for the data_set" do
      expect(data_stat.chi_square).to eq(1.0)
    end
  end
end
