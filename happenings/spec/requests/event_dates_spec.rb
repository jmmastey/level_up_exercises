require 'rails_helper'

RSpec.describe "EventDates", type: :request do
  describe "GET /event_dates" do
    it "works! (now write some real specs)" do
      get event_dates_path
      expect(response).to have_http_status(200)
    end
  end
end
