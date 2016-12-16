require 'rails_helper'

describe SunlightlabsApi do
  include SunlightlabsApi
  let(:default_params) { { page: { count: 1 } } }

  describe '.bills' do
    context 'pulling all bill data' do
      before do
        @legislator = create(:legislator)
        bill_data = { bill_id: 'hr123-114', bill_type: 'hr',
                      introduced_on: '2015-01-01',
                      sponsor: { first_name: @legislator.first_name,
                                 last_name: @legislator.last_name },
                      last_action: { acted_at: '2015-01-01' },
                      last_version: { urls: { pdf: 'long_bill.pdf' } },
                      actions: [{ acted_at: '2015-01-01',
                                  text: 'Introduced to Senate' }],
                      keywords: %w(Unemployment Finance)
                    }
        json_response = default_params.merge('results' => [bill_data]).to_json
        stub_request(:get, /congress.api.sunlightfoundation.com/)
          .to_return(status: 200, body: json_response)
      end

      it 'creates 1 bill with all the attributes' do
        get_bills_from_api
        expect(Bill.count).to eq(1)
        bill = Bill.first
        expect(bill.bill_id).to eq('hr123-114')
        expect(bill.bill_type).to eq('hr')
        expect(bill.legislator).to eq(@legislator)
        expect(bill.introduced_on).to eq(Date.parse('2015-01-01'))
        expect(bill.last_action_at).to eq(Date.parse('2015-01-01'))
        expect(bill.last_version_pdf).to eq('long_bill.pdf')
      end

      it 'creates 1 bill action' do
        get_bills_from_api
        expect(Bill.first.bill_actions.count).to eq(1)
      end

      it 'creates 2 tags and 2 bill tags' do
        get_bills_from_api
        expect(Tag.count).to eq(2)
        expect(Tag.pluck(:name)).to contain_exactly('Unemployment', 'Finance')
        expect(Bill.first.tags.count).to eq(2)
      end
    end

    context 'pulling minimal bill data' do
      before do
        bill_data = { bill_id: 'hr123-114', bill_type: 'hr' }
        json_response = default_params.merge('results' => [bill_data]).to_json
        stub_request(:get, /congress.api.sunlightfoundation.com/)
          .to_return(status: 200, body: json_response)
      end

      it 'creates 1 bill with just 2 attributes' do
        get_bills_from_api
        expect(Bill.count).to eq(1)
        bill = Bill.first
        expect(bill.bill_id).to eq('hr123-114')
        expect(bill.bill_type).to eq('hr')
      end
    end
  end

  describe '.legislators' do
    context 'pulling all legislator data' do
      before do
        legislator_data = { first_name: 'John', last_name: 'Boehner',
                            state: 'OH', party: 'R', title: 'Rep',
                            leadership_role: 'Speaker', district: '8'
                          }
        json_response = default_params.merge('results' => [legislator_data]).to_json
        stub_request(:get, /congress.api.sunlightfoundation.com/)
          .to_return(status: 200, body: json_response)
      end

      it 'creates 1 legislator' do
        get_legislators_from_api
        expect(Legislator.count).to eq(1)
        expect(Legislator.first.first_name).to eq('John')
        expect(Legislator.first.last_name).to eq('Boehner')
      end
    end

    context 'pulling minimal legislator data' do
      before do
        legislator_data = { first_name: 'John', last_name: 'Boehner' }
        json_response = default_params.merge('results' => [legislator_data]).to_json
        stub_request(:get, /congress.api.sunlightfoundation.com/)
          .to_return(status: 200, body: json_response)
      end

      it 'creates 1 legislator' do
        get_legislators_from_api
        expect(Legislator.count).to eq(1)
        expect(Legislator.first.first_name).to eq('John')
        expect(Legislator.first.last_name).to eq('Boehner')
      end
    end
  end
end
