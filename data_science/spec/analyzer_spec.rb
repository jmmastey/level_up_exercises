require_relative '../analyzer'

describe Analyzer do
  let(:filename) { 'test.json' }
  let(:analyzer) { Analyzer.new(filename) }

  describe '#initialize' do
    it 'sets the filename for a new Analyzer instance' do
      expect(analyzer).to be_a(Analyzer)
      expect(analyzer.filename).to eq(filename)
    end
  end

  describe "#parse_data" do
    let(:cohort_data) { analyzer.parse_data }
    it "creates a hash of cohort and their respective results" do
      expect(cohort_data).to be_a(Hash)
      expect(cohort_data.values).to be_a(Array)
      expect(cohort_data.keys).to eq(%w(B A))
    end
  end
end
