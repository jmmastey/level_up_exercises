require 'rails_helper'
require "factory_girl"
require "pry"
require "byebug"

RSpec.describe CalendarEvent, :type => :model do

  let(:raw_event) { build(:basic_event) }
  let(:saved_event) { create(:basic_event) }

  let(:sister_event) {
    e = build(:basic_event)
    e.start_time = e.start_time + 1.day
    e.end_time = e.end_time + 1.day
    e
  }

  let(:copy_event) do
    e = CalendarEvent.new

    raw_event.attribute_names.map do |attr|
      next if attr == 'event_hash' || !raw_event.attribute_present?(attr)
      e[attr] = raw_event[attr]
    end

    e
  end


  it "has a title" do
    expect(raw_event.title).not_to be_nil
  end

  it "has a start time" do
    expect(raw_event.start_time).not_to be_nil
  end

  it "has an end time" do
    expect(raw_event.end_time).not_to be_nil
  end

  it "has an event hash" do
    expect(raw_event.event_hash).not_to be_nil
  end

  it "creates its event hash automatically" do
    raw_event.event_hash = nil
    expect(raw_event.event_hash).not_to be_nil
  end

  it "creates the same event hash as an identical event" do
    expect(copy_event.event_hash).to eq(raw_event.event_hash)
  end

  it "creates a different event hash from a non-identical event" do
    expect(sister_event.event_hash).not_to eq(raw_event.event_hash)
  end

  it "does not store multiple identical events" do
    saved_event
    expect { copy_event.save }.to raise_error
  end

  it "has a family hash" do
    expect(raw_event.family_hash).not_to be_nil
  end

  it "creates its family hash automatically" do
    raw_event.family_hash = nil
    expect(raw_event.family_hash).not_to be_nil
  end

  it "creates the same family hash as others in the family" do
    expect(sister_event.family_hash).to eq(raw_event.family_hash)
  end
end
