require 'rails_helper'

RSpec.describe "Bills", :type => :request do
  describe "GET /bills" do
    it "works! (now write some real specs)" do
      get bills_path
      expect(response).to have_http_status(200)
    end
  end
end
