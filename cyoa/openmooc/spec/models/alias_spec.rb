require 'rails_helper'

RSpec.describe Alias, :type => :model do

  let(:test_case_1) do
    'apple'
  end

  let(:test_case_1_result) do
    ["Apple Computer Company",
     "Apple Computers",
     "Apple Computer, Inc."]
  end

  let(:test_case_2) do
    'really wierd unknown string no one uses'
  end

  let(:test_case_2_result) do
    []
  end

  let(:no_aliases) do
    'Pasteur Institute'
  end

  let(:no_aliases_result) do
    []
  end

  describe '::query' do
    it 'returns the aliases from a query string' do
      VCR.use_cassette 'alias_query/1', record: :new_episodes do
        expect(
          described_class.query(test_case_1).map(&:text)
       ).to eq(test_case_1_result)
      end
    end

    it 'returns the aliases from a query string' do
      VCR.use_cassette 'alias_query/2', record: :new_episodes do
        expect(described_class.query test_case_2).to eq(test_case_2_result)
      end
    end

    it 'returns the aliases from a query string' do
      VCR.use_cassette 'alias_query/no_aliases', record: :new_episodes do
        expect(described_class.query no_aliases).to eq(no_aliases_result)
      end
    end
  end
end
