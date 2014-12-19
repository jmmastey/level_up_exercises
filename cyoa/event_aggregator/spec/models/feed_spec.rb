require 'rails_helper'

RSpec.describe Feed, :type => :model do
pending "NOT UNTIL SELECTION CRITERIA ARE IMPLEMENTED"

  let(:feed) { FactoryGirl.create(:feed) }
  let(:configured_feed) { FactoryGirl.create(:feed, :with_selectors) }
  #let(:populated_feed) {
  #  FactoryGirl.create(:feed, :with_criteria, :with_events)
  #}

  it "has a title" do
    expect(feed.title).not_to be_nil
  end

  it "can be retitled" do
    old_title = feed.title
    new_title = old_title.reverse
    feed.title = new_title
    feed.save
    expect(feed.title).not_to eq(old_title)
  end

  it "has an owner" do
    pending "Must implement user factory first"
  #  expect(feed.owner).not_to be_nil
  end

  it "has a description" do
    expect(feed.description).not_to be_nil
  end

  it "can have selection criteria" do
    expect(configured_feed.selection_criteria.count).to be > 0
  end

  it "can add selection criteria" do
    pending
  end

  it "can remove selection criteria" do
    pending
  end

  # it "selects different ecents when criteria change"
  #
  # it "can be deleted"

  it "selects events" do
    pending "Must implement event-selection-via-selection-criteria query mechanism"
  #  expect(populated_feed.events.count).to be > 0
  end

  #it "acquires new events" do
  #  orig_event_count = populated_feed.events.count
    # create_list(more events captured by feed)
  #  populated_feed.refresh
  #  expect(populated_feed.events.count).not_to eq(orig_event_count)
  #end
end
