require 'rails_helper'

describe LegislatorQuery do
  before do
    @legislator_1 = create(:legislator, title: 'Sen', party: 'D', state: 'NY', district: '8')
    @legislator_2 = create(:legislator, title: 'Del', party: 'D', state: 'IL', district: '9')
    @legislator_3 = create(:legislator, title: 'Sen', party: 'R', state: 'IL', district: '1')
    @il_zipcode = '60564'
    create(:congressional_district, zipcode: @il_zipcode, state: 'IL', congressional_district_id: 1)
    create(:congressional_district, zipcode: @il_zipcode, state: 'IL', congressional_district_id: 9)
  end

  describe '#search' do
    context 'by single parameter' do
      context 'full first name' do
        let(:legislator_query) { LegislatorQuery.new(Legislator.all, @legislator_1.first_name) }

        it 'searches for legislators who match the name' do
          expect(legislator_query.execute.count).to eq(1)
        end
      end

      context 'lowercase last name' do
        let(:legislator_query) { LegislatorQuery.new(Legislator.all, @legislator_2.last_name.downcase) }

        it 'searches for legislators who match the name' do
          expect(legislator_query.execute.count).to eq(1)
        end
      end

      context 'party' do
        let(:legislator_query) { LegislatorQuery.new(Legislator.all, 'Democratic') }

        it 'searches for legislators who are Democratic' do
          expect(legislator_query.execute.count).to eq(2)
        end
      end

      context 'full state name' do
        let(:legislator_query) { LegislatorQuery.new(Legislator.all, 'new York') }

        it 'searches for legislators who represent new york' do
          expect(legislator_query.execute.count).to eq(1)
        end
      end

      context 'state abbreviation' do
        let(:legislator_query) { LegislatorQuery.new(Legislator.all, 'IL') }

        it 'searches for legislators who represent Arizona' do
          expect(legislator_query.execute.count).to eq(2)
        end
      end

      context 'title' do
        let(:legislator_query) { LegislatorQuery.new(Legislator.all, 'Senator') }

        it 'searches for legislators who are Senators' do
          expect(legislator_query.execute.count).to eq(2)
        end
      end

      context 'abbreviated title' do
        let(:legislator_query) { LegislatorQuery.new(Legislator.all, 'del') }

        it 'searches for legislators who are Delegates' do
          expect(legislator_query.execute.count).to eq(1)
        end
      end

      context 'zipcode' do
        let(:legislator_query) { LegislatorQuery.new(Legislator.all, @il_zipcode) }

        it "searches for legislators who serve the zipcode #{@il_zipcode}" do
          expect(legislator_query.execute.count).to eq(2)
        end
      end
    end

    context 'by multiple parameters' do
      context 'zipcode and state' do
        let(:legislator_query) { LegislatorQuery.new(Legislator.all, "#{@il_zipcode} democratic") }

        it "searches for Democratics who serve in zipcode #{@il_zipcode}" do
          expect(legislator_query.execute.count).to eq(1)
        end
      end

      context 'first and last name' do
        let(:legislator_query) { LegislatorQuery.new(Legislator.all, "#{@legislator_1.first_name} #{@legislator_1.last_name}") }

        it 'searches for legislators by full name' do
          expect(legislator_query.execute.count).to eq(1)
        end
      end

      context 'state and title' do
        let(:legislator_query) { LegislatorQuery.new(Legislator.all, 'new York senator') }

        it 'searches for legislators who are Senators in New York' do
          expect(legislator_query.execute.count).to eq(1)
        end
      end

      context 'state, name, title, and party' do
        let(:legislator_query) { LegislatorQuery.new(Legislator.all, "illinois #{@legislator_2.first_name} #{@legislator_2.last_name} delegate democratic") }

        it 'searches for legislators who are Democratic Delegators in Illinois by name' do
          expect(legislator_query.execute.count).to eq(1)
        end
      end
    end
  end
end
