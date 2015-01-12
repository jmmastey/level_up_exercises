require 'rails_helper'

RSpec.describe Feed, :type => :model do

  let(:feed) { FactoryGirl.create(:feed) }
  let(:owned_feed) { FactoryGirl.create(:feed, :with_owner) }
  let(:configured_feed) { FactoryGirl.create(:feed, :with_selectors) }
  let(:populated_feed) {
    FactoryGirl.create(:feed, :with_events)
  }
  let (:new_selection_criteria) {
    create(
      :selection_criterion,
      field: :start_time,
      sql_operator: ">",
      criterion: Time.now + 3.days
    )
  }

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
    expect(owned_feed.user).not_to be_nil
  end

  it "has a description" do
    expect(feed.description).not_to be_nil
  end

  it "can have selection criteria" do
    expect(configured_feed.selection_criteria.count).to be > 0
  end

  it "can add selection criteria" do
    create(:selection_criterion, field: "foo", feed: feed)
    create(:selection_criterion, sql_operator: "==", feed: feed)
    create(:selection_criterion, criterion: "bar", feed: feed)
    expect(configured_feed.selection_criteria.count).to be(3)
  end

  it "can remove selection criteria" do
    configured_feed.selection_criteria.to_a.each { |crit| crit.destroy }
    expect(configured_feed.selection_criteria.count).to be(0)
  end

  it "has events" do
    expect(populated_feed.calendar_events.count).to be > 0
  end
  
  it "can be deleted" do
    feed
    n = Feed.count
    feed.destroy
    expect(Feed.count).to be(n - 1)
  end

  it "acquires new events" do
    now = Time.now.to_i
    orig_event_count = populated_feed.calendar_events.count
    populated_feed.selection_criteria << new_selection_criteria
    (now .. now + 5.days).step(1.day).map { |sec| Time.at(sec) }.each do |t|
      create(
        :calendar_event,
        title: 'New event',
        start_time: t,
        end_time: t + 1.hour
      )
    end
    populated_feed.capture_new_events
    expect(populated_feed.calendar_events.count).to eq(orig_event_count + 2)
  end

  it "selects different events when criteria change" do
    pending "Flush events and criteria, add new criteria, " \
            "acquire different events"
  end
end
