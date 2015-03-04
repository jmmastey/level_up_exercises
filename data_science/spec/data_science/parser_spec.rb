require 'spec_helper'
require 'pry'

module DataScience
  describe Parser do
    let(:parser) {Parser.new('test.json')}
    let(:json) {parser.parse}
    describe '#exists' do 
      it "checks the existence of a file" do
        expect(parser).to exist        
      end
    end
    describe '#parse' do
      it "returns an array" do
        expect(json.class).to eq(Array)
        
#        match 
#          a_hash_including("date"=>"2014-03-20",
#                           "cohort"=>"B",
#                           "result"=>"0")
      end
    end
  end
end
