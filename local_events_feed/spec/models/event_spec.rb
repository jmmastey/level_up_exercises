require 'rails_helper'
require 'models/event_helper'

RSpec.describe Event, :type => :model do
  let(:event) { create_event('Party', 'Everywhere', 'www.link.com') }
  let(:multiple_events) do
    create_event('Party-B', 'Everywhere', 'www.link.com')
    create_event('Party-C', 'Everywhere', 'www.link.com')
    create_event('Party-A', 'Everywhere', 'www.link.com')
  end

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

  it 'responds to description' do
    expect(event).to respond_to(:description)
  end

  it 'can sort by event name' do
    multiple_events
    expect(Event.all.sorted[0].name).to eq('Party-A')
    expect(Event.all.sorted[1].name).to eq('Party-B')
    expect(Event.all.sorted[2].name).to eq('Party-C')
  end
end
