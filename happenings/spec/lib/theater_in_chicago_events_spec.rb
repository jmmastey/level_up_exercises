require 'rails_helper'

describe TheatreInChicagoEvents do
  describe '#get_events_for_month' do
    context 'input validation' do
      it 'should raise an error for invalid month values' do
        expect { described_class.new({ month: 13, year: 2010 }).get_events_for_month }.
          to raise_error(ArgumentError, "invalid month value: 13")
      end

      it 'should raise an error for invalid year values' do
        expect { described_class.new({ month: 11, year: 1989 }).get_events_for_month }.
          to raise_error(ArgumentError, "invalid year value: 1989")
      end
    end

    context 'parsing' do
      let(:monthly_response) do
        File.open(Rails.root + 'spec/support/theatre_monthly_response.html', 'rb') { |f| f.read }
      end

      before(:each) do
        allow(HTTParty).to receive(:get).and_return(monthly_response)
      end

      it 'should parse stuff' do
        raw_events = described_class.new({ month: 1, year: 2015 }).get_events_for_month
        expect(raw_events.count).to eq(7)
      end
    end
  end

  describe '#get_events_for_year' do
  end
end
