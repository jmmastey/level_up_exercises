require_relative '../parser.rb'

describe Parser do
  before { File.stub(:read).and_return(json_text) }

  let(:parser) { Parser.parse('') }
  let(:json_text) {
    <<DATA
    [
      {
        "date": "2014-03-20",
        "cohort": "A",
        "result": 0
      },
      {
        "date": "2014-03-20",
        "cohort": "B",
        "result": 1
      },
      {
        "date": "2014-03-21",
        "cohort": "B",
        "result": 0
      }
    ]
DATA
  }

  PARSED = [{ "date" => "2014-03-20", "cohort" => "A", "result" => 0 }, { "date" => "2014-03-20", "cohort" => "B", "result" => 1 }, { "date" => "2014-03-21", "cohort" => "B", "result" => 0 }]

  describe '#parse' do
    it 'returns an the correct format' do
      expect(parser).to eq(PARSED)
    end
  end
end
