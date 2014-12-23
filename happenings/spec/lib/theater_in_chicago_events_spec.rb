require 'rails_helper'

describe TheatreInChicagoEvents do
  let(:monthly_response) do
    File.open(Rails.root + 'spec/support/theatre_monthly_response.html', 'rb') { |f| f.read }
  end

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
      before(:each) do
        allow(HTTParty).to receive(:get).and_return(monthly_response)
      end

      it 'should parse out the correct number of events' do
        raw_events = described_class.new({ month: 1, year: 2015 }).get_events_for_month
        expect(raw_events.count).to eq(7)
      end

      it 'should parse the data into correct data types for each raw event' do
        raw_events = described_class.new({ month: 1, year: 2015 }).get_events_for_month
        raw_events.each do |event|
          expect(event[:description].class).to eq(String)
          expect(event[:title].class).to eq(String)
          expect(event[:url].class).to eq(String)
          expect(event[:time].class).to eq(String)
          expect(event[:date].class).to eq(Date)
          expect(event[:event_source]).to eq(:theatre_in_chicago)
        end
      end

      it 'should correctly parse each event attribute' do
        raw_events = described_class.new({ month: 1, year: 2015 }).get_events_for_month
        expect(raw_events.first[:description]).to eq("Cor Theatre at Rivendell Theatre")
        expect(raw_events.first[:url]).to eq("http://www.theatreinchicago.com/a-map-of-virtue/7381/")
        expect(raw_events.first[:title]).to eq("A Map of Virtue")
        expect(raw_events.first[:time]).to eq("5:00pm")
        expect(raw_events.first[:date]).to eq(Date.parse("2015-01-11"))
      end
    end
  end
  
  describe '#get_events_between_dates' do
    before(:each) do
      allow(HTTParty).to receive(:get).and_return(monthly_response)
      allow(TheatreInChicagoEvents).to receive(:get_events_for_month) do |month, year|
        if month != 1
          []
        else
          TheatreInChicagoEvents.new({ month: month, year: year }).get_events_for_month
        end
      end
    end

    it 'should filter out events not in range' do
      start_date = Date.parse("2015-01-12")
      end_date = Date.parse("2015-01-19")
      raw_events = described_class.get_events_between_dates(start_date, end_date)
      expect(raw_events.count).to eq(3)
    end
  end
end
