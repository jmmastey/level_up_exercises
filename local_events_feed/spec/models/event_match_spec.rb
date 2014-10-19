require 'rails_helper'
require 'models/event_helper'

RSpec.describe Event, :type => :model do
  let(:event_a) { new_event('Party', 'Everywhere', 'www.event.com') }
  let(:event_b) { new_event('Party', 'Everywhere', 'www.event.com') }
  let(:event_c) { new_event('Partx', 'Everywhere', 'www.event.com') }
  let(:event_d) { new_event('Party', 'Everywherx', 'www.event.com') }
  let(:event_e) { new_event('Party', 'Everywhere', 'www.event.coz') }
  let(:list_1) { [event_a, event_b, event_c, event_d] }
  let(:list_2) { [event_c, event_d, event_e] }
  let(:unique_event)    { new_event("Party A", "North Side", "www.event.comX") }
  let(:duplicate_event) { new_event("Party A", "North Side", "www.party.com/party-a.html") }

  it 'matches another event with identical data fields' do
    expect(event_a).to be_same_as(event_b)
  end

  it 'does not match another event with different name' do
    expect(event_a).not_to be_same_as(event_c)
  end

  it 'does not match another event with different location' do
    expect(event_a).not_to be_same_as(event_d)
  end

  it 'does not match another event with different link' do
    expect(event_a).not_to be_same_as(event_e)
  end

  it 'has a matching item in a list' do
    expect(event_a).to have_match_in(list_1)
  end

  it 'does not have a matching item in a list' do
    expect(event_a).not_to have_match_in(list_2)
  end

  it 'recognizes that it is unique in the database' do
    create_events
    expect(unique_event).to be_valid
  end

  it 'recognizes that it is not unique in the database' do
    create_events
    expect(duplicate_event).not_to be_valid
  end
end
