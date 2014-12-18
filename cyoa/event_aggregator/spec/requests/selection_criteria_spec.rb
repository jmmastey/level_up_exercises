require 'rails_helper'

RSpec.describe "SelectionCriteria", :type => :request do
  describe "GET /selection_criteria" do
    it "works! (now write some real specs)" do
      get selection_criteria_path
      expect(response).to have_http_status(200)
    end
  end
end
