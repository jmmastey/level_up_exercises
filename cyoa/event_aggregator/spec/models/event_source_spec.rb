require 'rails_helper'

RSpec.describe EventSource, :type => :model do

  let(:source) { FactoryGirl.create(:event_source) }
  let(:populated_source) do
    FactoryGirl.create(:event_source, :with_events, events_count: 3)
  end

  it "has a name" do
    expect(source.name).not_to be_nil
  end

  it "has a uri" do
    expect(source.uri).not_to be_nil
  end

  it "has a data collection frequency" do
    expect(source.frequency).not_to be_nil
  end
  
  it "can have calendar events" do
    expect(populated_source.calendar_events.count).to eq(3)
  end
end
