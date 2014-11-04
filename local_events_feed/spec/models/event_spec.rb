require 'rails_helper'
require 'models/event_helper'

RSpec.describe Event, :type => :model do
  let(:event) { create_event('Party', 'Everywhere', 'www.link.com') }
  let(:showing) { event.add_showing(time: DateTime.parse('20141001')) }

  let(:another_event) { new_event('Party', 'Everywhere', 'www.link.com') }
  let(:another_showing) { another_event.add_showing(time: DateTime.parse('20141002')) }
  let(:add_another_event) do
    showing
    another_showing
    another_event.add_to_db
  end

  let(:showing_times) { [DateTime.parse('20141001'), DateTime.parse('20141002'), DateTime.parse('20141003')] }
  let(:event_with_showings) { create_event('Party', 'Everywhere', 'www.link.com', showing_times) }
  let(:duplicate_time_showing) { event.add_showing(time: showing.time) }
  let(:bad_time_showing)  { event.add_showing }

  it 'responds to name' do
    expect(event).to respond_to(:name)
  end

  it 'responds to location' do
    expect(event).to respond_to(:location)
  end

  it 'responds to showings' do
    expect(event).to respond_to(:showings)
  end

  it 'responds to link' do
    expect(event).to respond_to(:link)
  end

  it 'responds to image' do
    expect(event).to respond_to(:image)
  end

  it 'can add a showing' do
    expect{ showing }.to change { event.showings.count }.by(1)
  end

  it 'can add a showing to an existing identical event' do
    add_another_event
    expect(event).to have(2).showings
  end

  it 'can show a date range of showings' do
    expect(event_with_showings.pretty_date_range).to eq('Oct 1 - Oct 3, 2014')
  end

  it 'can show single-day showings date-range' do
    showing
    expect(event.pretty_date_range).to eq('Oct 1, 2014 Only')
  end

  it 'can show an empty showings date-range' do
    expect(event.pretty_date_range).to eq('No Showings')
  end

  it 'can show a pretty count of showings' do
    expect(event_with_showings.pretty_showing_count).to eq('3 Showings')
  end

  it 'can show a pretty count of empty showings' do
    expect(event.pretty_showing_count).to eq('No Showings')
  end

  it 'can show a pretty count of one showings' do
    showing
    expect(event.pretty_showing_count).to eq('1 Showing')
  end

  it 'can show a sorted list of showings' do
    expect(event_with_showings.sorted_showings[0].time.day).to eq(1)
    expect(event_with_showings.sorted_showings[1].time.day).to eq(2)
    expect(event_with_showings.sorted_showings[2].time.day).to eq(3)
  end

  it 'will not create a duplicate showing' do
    showing
    expect{ duplicate_time_showing }.not_to change { event.showings.count }
  end

  it 'will not create an invalid showing' do
    expect{ bad_time_showing }.not_to change { event.showings.count }
  end
end
