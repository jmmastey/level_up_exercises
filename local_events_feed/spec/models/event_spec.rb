require 'rails_helper'
require 'models/event_helper'

RSpec.describe Event, :type => :model do
  let(:event) { new_event('Party', 'Everywhere', "2014-10-01T09:30:00-05:00", "www.link.com") }

  it "responds to name" do
    expect(event).to respond_to(:name)
  end

  it "responds to location" do
    expect(event).to respond_to(:location)
  end

  it "responds to time" do
    expect(event).to respond_to(:time)
  end

  it "responds to link" do
    expect(event).to respond_to(:link)
  end

  it "displays chicago time correctly" do
    expect(event.to_chicago_time_s).to eq("10/01/2014 09:30 am")
  end
end
