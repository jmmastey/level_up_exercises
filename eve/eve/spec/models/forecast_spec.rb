require 'rails_helper'

RSpec.describe Forecast, :type => :model do
  subject(:forecast) { FactoryGirl.create(:forecast) }

  it "requires a valid date" do
    expect(forecast).to be_valid

    forecast.target_date = nil
    expect(forecast).not_to be_valid
  end

  it "requires a valid parent request" do
    forecast.forecast_request = nil
    expect(forecast).not_to be_valid
  end
end
