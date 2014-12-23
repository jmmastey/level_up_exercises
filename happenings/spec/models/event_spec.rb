require 'rails_helper'

describe Event do
  let(:event) { create :event }

  describe 'ical' do
    it 'should return an ical object' do
      ical_event = event.to_ics
      expect(ical_event.class).to eq(Icalendar::Event)
    end

    it 'should have properties of the event object' do
      ical_event = event.to_ics
      expect(ical_event.summary).to eq(event.title)
      expect(ical_event.description).to match(/link/)
      expect(ical_event.description).to match(/desc/)
    end
  end
end
