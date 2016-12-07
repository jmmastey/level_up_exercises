require 'rails_helper'
require_relative '../models/event_helper'

RSpec.describe ShowingsHelper, :type => :helper do

  let(:no_showings) { create_event('Party', 'Everywhere', "www.link.com").showings }

  let(:one_time) { [DateTime.parse('20141001T190000')] }
  let(:one_showing) { create_event('Party', 'Everywhere', "www.link.com", one_time).showings }

  let(:one_day_times) { [ DateTime.parse('20141001T190000'),
                          DateTime.parse('20141001T210000')] }
  let(:one_day_showings) { create_event('Party', 'Everywhere', "www.link.com", one_day_times).showings }

  let(:multi_day_times) { [DateTime.parse('20141001T190000'), 
                           DateTime.parse('20141002T190000'), 
                           DateTime.parse('20141003T190000')] }
  let(:multi_day_showings) { create_event('Party', 'Everywhere', "www.link.com", multi_day_times).showings }

  let(:model_event) { one_showing.event }

  let(:tic_event) do
    tic_event = TheatreInChicago::Event.new
    tic_event.name = 'Party'
    tic_event.location = 'Everywhere'
    tic_event.link = 'www.link.com'
    tic_event.showings = multi_day_times
    tic_event
  end

  let(:add_tic_event) { ShowingsHelper.add_theatre_in_chicago(tic_event) }
  let(:find_event) { Event.find_by(name: 'Party', location: 'Everywhere', link: 'www.link.com') }


  it 'can show a multi-day showings date-range' do
    expect(ShowingsHelper.pretty_date_range(multi_day_showings)).to eq('Oct 1 - Oct 3, 2014')
  end

  it 'can show single-day showings date-range' do
    expect(ShowingsHelper.pretty_date_range(one_showing)).to eq('Oct 1, 2014 Only')
  end

  it 'can show an empty showings date-range' do
    expect(ShowingsHelper.pretty_date_range(no_showings)).to eq('No Showings')
  end

  it 'can show a pretty count of showings' do
    expect(ShowingsHelper.pretty_showing_count(multi_day_showings)).to eq('3 Showings')
  end

  it 'can show a pretty count of empty showings' do
    expect(ShowingsHelper.pretty_showing_count(no_showings)).to eq('No Showings')
  end

  it 'can show a pretty count of one showings' do
    expect(ShowingsHelper.pretty_showing_count(one_showing)).to eq('1 Showing')
  end

  it 'can tell if a list of showings are on one day only' do
    expect(ShowingsHelper.one_day_only?(one_day_showings)).to be true
  end

  it 'can tell if a list of showings are on one day only' do
    expect(ShowingsHelper.one_day_only?(multi_day_showings)).to be false
  end

  it 'can add a TheatreInChicago event' do
    add_tic_event
    expect(find_event.showings.size).to eq(3)
  end

  it 'can add a TheatreInChicago event showings to an existing event' do
    one_showing
    add_tic_event
    expect(find_event.showings.size).to eq(3)
  end
end
