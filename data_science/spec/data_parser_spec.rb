require_relative '../data_parser'

LIST_LENGTH = 2
SAMPLE_SIZE = 72
NUM_CONVERSIONS = 5
COHORT_NAME = :A

describe DataParser do
  let(:parsed_data) { DataParser.new('smaller_data_set.json') }

  describe("#new") do 
    it "has 2 instance variables which are dictionaries" do
      expect(parsed_data.unique_cohorts).to(be_an_instance_of(Hash))
      expect(parsed_data.unique_cohorts_conversions).to(be_an_instance_of(Hash))
    end
  end

   it "has 2 instance variables with 2 keys each" do 
     expect(parsed_data.unique_cohorts.keys.length).to(eql(LIST_LENGTH))
     expect(parsed_data.unique_cohorts_conversions.keys.length).to(eql(LIST_LENGTH))
   end

  it "has an instance variable with key :A and  sample_size as the value" do 
    expect(parsed_data.unique_cohorts[COHORT_NAME]).to(eql(SAMPLE_SIZE))
  end

  it "has an instance variable with key :A and num_conversions as the value" do 
    expect(parsed_data.unique_cohorts_conversions[COHORT_NAME]).to(eql(NUM_CONVERSIONS))
  end
end
