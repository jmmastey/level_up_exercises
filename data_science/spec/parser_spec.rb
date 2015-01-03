require_relative '../parser.rb'

describe Parser do
  let(:parser) { Parser.parse(filepath) }
  let(:filepath) { 'test.json' }

  PARSED = [{ "date" => "2014-03-20", "cohort" => "A", "result" => 0 }, { "date" => "2014-03-20", "cohort" => "B", "result" => 1 }, { "date" => "2014-03-21", "cohort" => "B", "result" => 0 }]

  describe '#parse' do
    it 'returns an the correct format' do
      expect(parser).to eq(PARSED)
    end
  end

end
