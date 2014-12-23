require 'rails_helper'

describe EventSearch do
  let!(:event)           { create :event }
  let!(:old_event)       { create :event, date: Date.today - 20 }
  let!(:newer_event)     { create :event, date: Date.today + 20 }
  let!(:dff_desc_event)  { create :event, description: "foo" }
  let!(:params)          { {} }

  context 'filtering description' do
    it 'shouldnt filter if no description criteria was given' do
      events = EventSearch.call(params)
      expect(events.sort).to eq([event, old_event, newer_event, dff_desc_event].sort)
    end

    it 'should filter by description' do
      params[:description] = "foo"
      events = EventSearch.call(params)
      expect(events.sort).to eq([dff_desc_event])
    end
  end

  context 'filtering events by date' do
    it 'shouldnt filter if no date criteria was given' do
      events = EventSearch.call(params)
      expect(events.sort).to eq([event, old_event, newer_event, dff_desc_event].sort)
    end

    it 'should filter out older dated events' do
      params[:start_date] = old_event.date + 5
      events = EventSearch.call(params)
      expect(events.sort).to eq([event, newer_event, dff_desc_event].sort)
    end

    it 'should filter out newer dated events' do
      params[:end_date] = newer_event.date - 5
      events = EventSearch.call(params)
      expect(events.sort).to eq([event, old_event, dff_desc_event].sort)
    end
  end

  context 'filtering events by event source' do
    it 'should use theatre in chicago by default' do
      params[:event_source] = nil
      events = EventSearch.call(params)
      expect(events.sort).to eq([event, old_event, newer_event, dff_desc_event].sort)
    end

    it 'should filter if source is given' do
      EventSource.lookup.create(event_source: "bar")
      params[:event_source] = :bar
      events = EventSearch.call(params)
      expect(events.sort).to eq([])
    end
  end
end
