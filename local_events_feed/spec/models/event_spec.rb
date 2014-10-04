require 'rails_helper'
require 'models/event_helper'

RSpec.describe Event, :type => :model do
  let(:event_a) { create_event('Party', 'Everywhere', "2014-10-01T09:30:00") }
  let(:event_b) { create_event('Party', 'Everywhere', "2014-10-01T09:30:00") }
  let(:event_c) { create_event('Partx', 'Everywhere', "2014-10-01T09:30:00") }
  let(:event_d) { create_event('Party', 'Everywherx', "2014-10-01T09:30:00") }
  let(:event_e) { create_event('Party', 'Everywhere', "2014-10-01T09:30:01") }
  let(:list_1) { [event_a, event_b, event_c, event_d, event_e] }
  let(:list_2) { [event_c, event_d, event_e] }

  it 'matches another event with identical data fields' do
    expect(event_a.match?(event_b)).to be true
  end

  it 'does not match another event with difference name' do
    expect(event_a.match?(event_c)).to be false
  end

  it 'does not match another event with difference location' do
    expect(event_a.match?(event_d)).to be false
  end

  it 'does not match another event with difference time' do
    expect(event_a.match?(event_e)).to be false
  end

  it 'has a matching item in a list' do
    expect(event_a.has_match_in?(list_1)).to be true
  end

  it 'does not have a matching item in a list' do
    expect(event_a.has_match_in?(list_2)).to be false
  end
end
