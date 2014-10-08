require 'rails_helper'
require 'models/event_helper'

RSpec.describe Event, :type => :model do
  let(:event) { create_event('Party', 'Everywhere', "2014-10-01T09:30:00") }

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
end
