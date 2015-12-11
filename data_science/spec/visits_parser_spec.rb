require 'spec_helper'
require_relative '../lib/visits_parser'

describe VisitsParser do
  let(:data) do
    [{ "date": "2014-03-20", "cohort": "B", "result": 0 },
     { "date": "2014-03-20", "cohort": "B", "result": 0 },
     { "date": "2014-03-20", "cohort": "B", "result": 0 }]
  end
  describe ".parse" do
    it 'creates the correct number of Visits from JSON data' do
      expect(VisitsParser.parse(data).length).to eq(3)
    end

    it 'creates objects that respond to cohort with a truthy value' do
      object = VisitsParser.parse(data).first
      expect(object.cohort).to be_truthy
    end
  end
end
