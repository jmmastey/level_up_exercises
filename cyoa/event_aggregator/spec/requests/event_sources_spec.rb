require 'rails_helper'

RSpec.describe "EventSources", :type => :request do
  describe "GET /event_sources" do
    it "works! (now write some real specs)" do
      get event_sources_path
      expect(response).to have_http_status(200)
    end
  end
end
