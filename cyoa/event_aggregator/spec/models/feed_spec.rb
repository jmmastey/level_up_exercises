require 'rails_helper'

RSpec.describe Feed, :type => :model do
pending "NOT UNTIL SELECTION CRITERIA ARE IMPLEMENTED"

  let(:feed) { FactoryGirl.create(:feed) }
  let(:configured_feed) { FactoryGirl.create(:feed, :with_criteria) }
  let(:populated_feed) {
    FactoryGirl.create(:feed, :with_criteria, :with_events)
  }

  it "has a name" do
    expect(feed.name).not_to be_nil
  end

  it "can be renamed" do
    old_name = feed.name
    new_name = old_name.reverse
    feed.name = new_name
    feed.save
    expect(feed.name).not_to eq(old_name)
  end

  it "has an owner" do
    expect(feed.owner).not_to be_nil
  end

  #it "can have selection criteria" do
  #  expect(configured_feed.criteria.count).to be > 0
  # end

  #it "selects events" do
  #  expect(populated_feed.events.count).to be > 0
  # end

  it "acquires new events" do
    orig_event_count = populated_feed.events.count
    # create_list(more events captured by feed)
    populated_feed.refresh
    expect(populated_feed.events.count).not_to eq(orig_event_count)
  end

  #it "can add selection criteria" do
  #  new_criteria = 
  #
  # it "can remove selection criteria"

  # it "selects different ecents when criteria change"
  #
  # it "can be deleted"
end
