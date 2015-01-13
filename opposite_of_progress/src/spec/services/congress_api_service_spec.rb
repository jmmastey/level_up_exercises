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

  context '.sync_legislators' do
    let(:legislator_class) do
      class_double('Legislator').as_stubbed_const(transfer_nested_constants: true)
    end

    let(:legislator_model) { double('legislator_model') }

    let(:congress_api) do
      class_double('Congress').as_stubbed_const(transfer_nested_constants: true)
    end

    let(:results) do
      results = 20.times.map { {} }
      { count: 43, results: results }
    end

    let(:results_partial) do
      results = 3.times.map { {} }
      { count: 43, results: results }
    end

    before(:each) do
      allow(legislator_model).to receive(:update_attributes)
      allow(legislator_class).to receive(:find_or_initialize_by)
        .and_return(legislator_model)
      allow(congress_api).to receive(:legislators)
        .and_return(results, results, results, results_partial)
    end

    it 'creates or updates correct number of models' do
      CongressApiService.sync_legislators
      expect(congress_api).to have_received(:legislators).exactly(4)
        .times
      expect(legislator_class).to have_received(:find_or_initialize_by)
        .exactly(43).times
      expect(legislator_model).to have_received(:update_attributes)
        .exactly(43).times
    end
  end
end
