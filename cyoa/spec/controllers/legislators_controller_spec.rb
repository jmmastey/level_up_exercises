require 'rails_helper'

describe LegislatorsController, type: :controller do
  render_views
  context 'JSON' do
    let(:default_params) { { format: 'json' } }

    describe '#index' do
      before do
        create(:legislator, state: 'IL', title: 'Rep')
        create(:legislator, state: 'NJ', title: 'Rep')
      end

      context 'searching by state' do
        before do
          params = default_params.merge(legislator: { query: 'IL'}) 
          get(:index, params)
        end

        it 'contains one legislator' do
          expect(response).to be_success
          expect(json['legislators'].length).to eq(1)
        end
      end

      context 'searching by title' do
        before do
          params = default_params.merge(legislator: { query: 'Rep'})
          get(:index, params)
        end

        it 'contains two legislators' do
          expect(response).to be_success
          expect(json['legislators'].length).to eq(2)
        end
      end
    end

    describe '#show' do
      before do
        @legislator = create(:legislator, state: 'IL', title: 'Rep')
        create(:bill, legislator_id: @legislator.id)
        params = default_params.merge(id: @legislator.id)
        get(:show, params)
        json
      end

      it 'contains basic legislator attributes' do
        expect(response).to be_success
        expect(json['first_name']).to eq(@legislator.first_name)
        expect(json['last_name']).to eq(@legislator.last_name)
        expect(json['party']).to eq(@legislator.party)
        expect(json['title']).to eq(@legislator.title)
        expect(json['state']).to eq(@legislator.state)
      end

      it 'contains one sponsored bill' do
        expect(json['sponsored'].length).to eq(1)
      end
    end
  end
end
