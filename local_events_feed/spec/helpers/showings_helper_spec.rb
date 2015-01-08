require 'rails_helper'
require_relative '../models/event_helper'

RSpec.describe ShowingsHelper, :type => :helper do

  let(:no_showings) { create(:event).showings }

  let(:one_time) { [time(1, 19)] }
  let(:one_showing) { create(:event, times: one_time).showings }

  let(:one_day_times) { [time(1, 19), time(1, 21)] }
  let(:one_day_showings) { create(:event, times: one_day_times).showings }

  let(:multi_day_times) { [time(1, 19), time(2, 19), time(3, 19)] }
  let(:multi_day_showings) { create(:event, times: multi_day_times).showings }


  it 'can show a multi-day showings date-range' do
    expect(pretty_date_range(multi_day_showings)).to eq('Oct 1 - Oct 3, 2014')
  end

  it 'can show single-day showings date-range' do
    expect(pretty_date_range(one_showing)).to eq('Oct 1, 2014 Only')
  end

  it 'can show an empty showings date-range' do
    expect(pretty_date_range(no_showings)).to eq('0 Showings')
  end

  it 'can show a pretty count of showings' do
    expect(pretty_showing_count(multi_day_showings)).to eq('3 Showings')
  end

  it 'can show a pretty count of empty showings' do
    expect(pretty_showing_count(no_showings)).to eq('0 Showings')
  end

  it 'can show a pretty count of one showings' do
    expect(pretty_showing_count(one_showing)).to eq('1 Showing')
  end

  it 'can tell if a list of showings are on one day only' do
    expect(one_day_only?(one_day_showings)).to be true
  end

  it 'can tell if a list of showings are on one day only' do
    expect(one_day_only?(multi_day_showings)).to be false
  end


  context 'given a TheatreInChicago event' do
    let(:tic_event) { create(:chicago_event, showings: multi_day_times) }
    let(:add_tic_event) { ShowingsHelper.add_theatre_in_chicago(tic_event) }
    let(:find_event) { Event.find_by(name: 'Party', location: 'Everywhere', link: 'www.link.com') }

    it 'can add it as a new event when no match exists' do
      add_tic_event
      expect(find_event).to have(3).showings
    end

    it 'can add a its showings to an existing event that matches it' do
      one_showing
      add_tic_event
      expect(find_event).to have(3).showings
    end
  end
end
