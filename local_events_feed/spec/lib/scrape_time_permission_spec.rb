require 'rails_helper'
require 'scrape_time_permission'

RSpec.describe ScrapeTimePermission, :type => :model do
  let(:source) { "Some-Source" }

  let(:today)       { DateTime.parse("20140901T080000") }
  let(:later_today) { DateTime.parse("20140901T200000") }
  let(:tomorrow)    { DateTime.parse("20140902T080000") }

  let(:permission_today)       { ScrapeTimePermission.new(source, today) }
  let(:permission_later_today) { ScrapeTimePermission.new(source, later_today) }
  let(:permission_tomorrow)    { ScrapeTimePermission.new(source, tomorrow) }


  it "gives permission to scrape initially" do
    expect(permission_today).to be_granted
  end

  it "will not give permission to scrape immediately after a scrape" do
    expect(permission_today).to be_granted
    expect(permission_today).not_to be_granted
  end

  it "will not give permission to scrape only a little later" do
    expect(permission_today).to be_granted
    expect(permission_later_today).not_to be_granted
  end

  it "will give permission to scrape today and tomorrow" do
    expect(permission_today).to be_granted
    expect(permission_tomorrow).to be_granted
  end
end
