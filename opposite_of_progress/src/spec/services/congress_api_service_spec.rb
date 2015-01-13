require "rails_helper"

RSpec.describe CongressApiService, :type => :services do
  context '.search_by_address' do
    let(:congress_api) { class_double("Congress").as_stubbed_const(transfer_nested_constants: true) }
    let(:results) do
      {
        results: [
          {bioguide_id: 'W000001'},
          {bioguide_id: 'W000002'},
        ]
      }
    end

    before(:each) do
      allow(congress_api).to receive(:legislators_locate).and_return(results)
    end

    it 'calls legislators_locate with correct parameters' do
      CongressApiService.search_by_address('60005')
      expect(congress_api).to have_received(:legislators_locate).with('60005', fields: 'bioguide_id')
    end

    it 'returns correct legislator bioguide_ids' do
      results = CongressApiService.search_by_address('60005')
      expect(results).to contain_exactly('W000001', 'W000002')
    end
  end
end
