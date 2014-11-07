require 'rspec'
require 'active_support/all'
require 'flight_stats/schedule'
require 'flight_stats/local_time'

describe 'FlightStats Schedules API' do
  include LocalTime

  let(:api) { FlightStats::Schedule.new }
  let(:origin) { "ORD" }
  let(:destination) { "LGA" }
  let(:meeting_start) { DateTime.parse(2.days.from_now.strftime("%FTT12:06:00")) }
  let(:meeting_end) { DateTime.parse(2.days.from_now.strftime("%FTT13:06:00")) }

  context 'api call gets flights' do
    it 'should show flights from chicago to new york tomorrow' do
      expect(api.arrive(meeting_start, origin, destination).length).to be > 0
    end
  end

  context 'before meeting' do
    subject { api.arrive(meeting_start, origin, destination) }

    it 'flights exist' do
      expect(subject.length).to be > 0
    end

    it 'arrives before the meeting starts' do
      subject.each do |f|
        expect(f["arrivalTime"].to_datetime).to be < strip_timezone(meeting_start)
      end
    end

    it 'departs from my origin' do
      subject.each do |f|
        expect(f["departureAirportFsCode"]).to eq(origin)
      end
    end

    it 'arrives at my destination' do
      subject.each do |f|
        expect(f["arrivalAirportFsCode"]).to eq(destination)
      end
    end
  end

  context 'after meeting' do
    subject { api.leave(meeting_end, destination, origin) }

    it 'flights exist' do
      expect(subject.length).to be > 0
    end

    it 'departs after the meeting ends' do
      subject.each do |f|
        expect(strip_timezone(meeting_end)).to be < f["departureTime"].to_datetime
      end
    end

    it 'departs from my destination' do
      subject.each do |f|
        expect(f["departureAirportFsCode"]).to eq(destination)
      end
    end

    it 'arrives at my origin' do
      subject.each do |f|
        expect(f["arrivalAirportFsCode"]).to eq(origin)
      end
    end
  end
end
