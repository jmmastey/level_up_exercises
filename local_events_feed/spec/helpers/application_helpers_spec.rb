require 'rails_helper'

RSpec.describe ApplicationHelper, :type => :helper do
  let(:time) { DateTime.parse("20141001T093000-0500") }
  let(:local_time_view) { ApplicationHelper::LocalTimeView.new(time) }

  it "displays local time correctly" do
    expect(local_time_view.to_s).to eq("10/01/2014 09:30 am")
  end

  it "displays pretty local date correctly" do
    expect(local_time_view.pretty_date).to eq("Wed, Oct 1, 2014")
  end

  it "displays pretty local date without day of week correctly" do
    expect(local_time_view.pretty_date_no_dow).to eq("Oct 1, 2014")
  end

  it "displays pretty local date without the year correctly" do
    expect(local_time_view.pretty_date_no_year).to eq("Oct 1")
  end

  it "displays pretty local day-of-week" do
    expect(local_time_view.pretty_dow).to eq("Wed")
  end

  it "displays pretty local time correctly" do
    expect(local_time_view.pretty_time).to eq("09:30 am")
  end
end
