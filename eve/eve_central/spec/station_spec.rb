require_relative "spec_helper"
require_relative "../lib/eve_central/station"

describe EveCentral::Station do
  include_context "station_ids"

  let(:default_station) { EveCentral::Station.new(amarr6_tct_id)}
  let(:named_station) do
    EveCentral::Station.new(amarr6_tct_id, amarr6_tct_name)
  end

  it "is initialized with an ID" do
    expect(default_station.id).to eq(amarr6_tct_id)
  end

  it "can be initialized with an optional name" do
    expect(named_station.name).to eq(amarr6_tct_name)
  end

  it "should never be persisted" do
    expect(default_station).not_to be_persisted
  end

  it "should require the ID be an integer" do
    default_station.id = 0.5
    expect(default_station).not_to be_valid
  end

  it "should require the ID be nonnegative" do
    expect(default_station).to be_valid

    default_station.id = -1
    expect(default_station).not_to be_valid
  end

  context "when initialized with no id" do
    subject(:bad_station) { EveCentral::Station.new }

    it "should raise an error" do
      expect { bad_station }.to raise_error
    end
  end
end
