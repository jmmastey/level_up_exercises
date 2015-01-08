require 'rails_helper'
require 'theatre_in_chicago/event'

RSpec.describe TheatreInChicago::Event, :type => :asset do
  let(:event) { create(:chicago_event) }
  let(:dirty_event) { create(:chicago_event, :dirty) }
  let(:other_event) { event.clone }

  it 'has a clean location when cleaned' do
    expect(dirty_event.clean.location).to eq("Everywhere")
  end

  it "converts to a string correctly" do
    expect(event.clean.to_s).to eq('Party, Everywhere, www.link.com, www.link.com/picture.jpg')
  end

  it 'matches another event that has identical fields' do
    expect(event).to eq(other_event)
  end
end
