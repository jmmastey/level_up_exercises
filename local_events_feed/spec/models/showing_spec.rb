require 'rails_helper'
require_relative 'event_helper'

RSpec.describe Showing, :type => :model do
  let(:event) { create_event("Party A", "North Side", "www.link.com") }
  let(:showing) { event.add_showing(time: DateTime.parse("20141001T093000-0500")) }

  let(:showing_times) { [DateTime.parse('20141003'), DateTime.parse('20141001'), DateTime.parse('20141002')] }
  let(:event_with_showings) { create_event('Party', 'Everywhere', "www.link.com", showing_times) }
  let(:showings) { event_with_showings.showings }
  let(:sorted_showings) { Showing.sort_by_time(showings) }
  let(:destroy_event) { Event.delete(Event.all) }

  it "responds to time" do
    expect(showing).to respond_to(:time)
  end

  it "responds to event" do
    expect(showing).to respond_to(:event)
  end

  it "responds to ics" do
    expect(showing).to respond_to(:ics)
  end

  it "responds to name (delegated to event)" do
    expect(showing).to respond_to(:name)
  end

  it "responds to location (delegated to event)" do
    expect(showing).to respond_to(:location)
  end

  it "responds to link (delegated to event)" do
    expect(showing).to respond_to(:link)
  end

  it "responds to image (delegated to event)" do
    expect(showing).to respond_to(:image)
  end

  it "responds to description (delegated to event)" do
    expect(showing).to respond_to(:description)
  end

  it "displays local time correctly" do
    expect(showing.to_local_time_s).to eq("10/01/2014 09:30 am")
  end

  it "displays pretty local date correctly" do
    expect(showing.pretty_local_date).to eq("Wed, Oct 1, 2014")
  end

  it "displays pretty local date without day of week correctly" do
    expect(showing.pretty_local_date_no_dow).to eq("Oct 1, 2014")
  end

  it "displays pretty local day-of-week" do
    expect(showing.pretty_local_dow).to eq("Wed")
  end

  it "displays pretty local time correctly" do
    expect(showing.pretty_local_time).to eq("09:30 am")
  end

  it "sorts a list of showings" do
    expect(sorted_showings[0].time.day).to eq(1)
    expect(sorted_showings[1].time.day).to eq(2)
    expect(sorted_showings[2].time.day).to eq(3)
  end

  it 'can tell if a list of showings are on one day only' do
    showing
    expect(Showing.one_day_only?(event.showings)).to be true
  end

  it 'can tell if a list of showings are on one day only' do
    expect(Showing.one_day_only?(showings)).to be false
  end

  it "no longer exists when the event is destroyed" do
    expect(Showing.all).to be_empty
  end
end
