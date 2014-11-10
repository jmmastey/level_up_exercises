require 'data_science/json_parser'

describe JsonParser do
  it "parses a JSON file and returns a hash" do
    sample_file = File.join(File.dirname(__FILE__), 'source_data_test.json')
    expect(JsonParser.parse_file(sample_file)).to eq([{"date"=>"2014-03-20", "cohort"=>"B", "result"=>0}, {"date"=>"2014-03-20", "cohort"=>"B", "result"=>0}, {"date"=>"2014-03-20", "cohort"=>"B", "result"=>0}, {"date"=>"2014-03-20", "cohort"=>"B", "result"=>0}])
  end
end
