require 'rails_helper'

RSpec.describe ForecastRequest, :type => :model do
  subject(:request) { FactoryGirl.create(:forecast_request) }

  it "can be created via factory" do
    expect(request).to be_valid
  end

  it "requires an item" do
    request.item = nil
    expect(request).not_to be_valid
  end

  it "requires a start time for including historical data" do
    request.history_start_time = nil
    expect(request).not_to be_valid
  end

  it "requires a end time for including historical data" do
    request.history_end_time = nil
    expect(request).not_to be_valid
  end

  it "requires a number of days included in the forecast after the target date" do
    request.num_target_days = nil
    expect(request).not_to be_valid
  end

  it "requires a target date to include in the forecast" do
    request.target_date = nil
    expect(request).not_to be_valid
  end
end
