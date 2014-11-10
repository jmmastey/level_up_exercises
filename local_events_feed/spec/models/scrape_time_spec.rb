require 'rails_helper'
require 'models/scrape_time_helper'

RSpec.describe ScrapeTime, :type => :model do
  let(:one_hour) { Time.at(1.hour) }
  let(:nine_oclock) { DateTime.parse("20140901T093000") }
  let(:valid_scrape_time) { create_scrape_time("source_A", nine_oclock, one_hour) }
  let(:invalid_scrape_time) { create_scrape_time("", nine_oclock, one_hour) }
  let(:duplicate_source_scrape_time) { create_scrape_time("source_A", nine_oclock, one_hour) }
  let(:default_scrape_time) { create_scrape_time("source_A", nil, nil) }

  it "responds to source" do
    expect(valid_scrape_time).to respond_to(:source)
  end

  it "responds to last_scrape_at" do
    expect(valid_scrape_time).to respond_to(:last_scrape_at)
  end

  it "responds to inter_scrap_delay" do
    expect(valid_scrape_time).to respond_to(:inter_scrape_delay)
  end

  it "validates its fields" do
    expect(valid_scrape_time).to be_valid
  end

  it "recognizes an invalid record" do
    expect(invalid_scrape_time).to be_invalid
  end

  it "will not save records with duplicate sources" do
    valid_scrape_time
    expect(duplicate_source_scrape_time).to be_invalid
  end

  it "will fill in a default value for inter_scrape_delay" do
    expect(default_scrape_time.inter_scrape_delay.to_i).to eq(1.day)
  end

  it "gives permission to scrape initially" do
    expect(valid_scrape_time.permission_to_scrape?).to be true 
  end

  it "will not give permission to scrape immediately after a scrape" do
    expect(valid_scrape_time.permission_to_scrape?).to be true 
    expect(valid_scrape_time.permission_to_scrape?).to be false 
  end
end
