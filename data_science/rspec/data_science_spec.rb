require_relative '../data_science'

describe DataScience do
  context 'positive' do
    let(:file_path) { "test.json" }
    let(:data_science) { DataScience.new(file_path) }
    it "should have data" do
      expect(data_science.raw_data).to_not be_empty
    end

    it "should have two cohorts" do
      expect(data_science.cohorts.size).to eq(2)
    end

    it "should have a status of cohorts different" do
      expect(data_science.cohorts_different?).to be true
    end

  end
end
