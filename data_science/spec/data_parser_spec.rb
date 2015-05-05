require_relative '../data_parser'

LIST_LENGTH = 2
SAMPLE_SIZE = 72
NUM_CONVERSIONS = 5
COHORT_NAME = :A

describe DataParser do
  let(:parsed_data) { DataParser.new('smaller_data_set.json') }

  describe("#data_parser_object") do 
    it "contains 2 dictionaries with cohort names as keys and sample size/num conversions as values" do
      expect(parsed_data.cohorts_sample_size).to(be_an_instance_of(Hash))
      expect(parsed_data.cohorts_num_conversions).to(be_an_instance_of(Hash))
    end

    it "2 dictionaries have number of entries equal to the number of cohorts" do 
      expect(parsed_data.cohorts_sample_size.keys.length).to(eql(LIST_LENGTH))
      expect(parsed_data.cohorts_num_conversions.keys.length).to(eql(LIST_LENGTH))
    end

    it "dictionary key (that is cohort name) and value (that is number of trials in the cohort)" do 
      expect(parsed_data.cohorts_sample_size[COHORT_NAME]).to(eql(SAMPLE_SIZE))
    end

    it "dictionary has key (that is cohort name) and value (that is number of conversions in the cohort)" do 
      expect(parsed_data.cohorts_num_conversions[COHORT_NAME]).to(eql(NUM_CONVERSIONS))
    end
  end
end
