require 'rails_helper'

describe CreateEvent do
  let!(:event) { create :event }
  let(:new_valid_attributes) {
            { date: event.date + 1,
              time: event.time,
              title: event.title,
              description: event.description,
              url: event.url,
              event_source: event.event_source } }

  let(:duplicate_attributes) {
            { date: event.date,
              time: event.time,
              title: event.title,
              description: event.description,
              url: event.url,
              event_source: event.event_source } }

  let(:invalid_attributes) {
            { date: Date.today,
              time: Time.now,
              title: "tle",
              description: "",
              url: "url",
              event_source: event.event_source } }

  it 'should return nil if event exists' do
    result = CreateEvent.create(duplicate_attributes)
    expect(result).to eq(nil)
  end

  it 'should return an ActiveModel errors object if validations fail' do
    event_count = Event.count
    result = CreateEvent.create(invalid_attributes)
    expect(result.class).to eq(Event)
    expect(result.errors.class).to eq(ActiveModel::Errors)
    expect(Event.count).to eq(event_count)
  end

  it 'should return a event object with no errors if successful' do
    event_count = Event.count
    result = CreateEvent.create(new_valid_attributes)
    expect(result.class).to eq(Event)
    expect(Event.count).to eq(event_count + 1)
  end
end
