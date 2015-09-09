require 'rails_helper'

RSpec.describe "Realms", type: :request do
  describe "GET /realms" do
    it "works! (now write some real specs)" do
      get realms_path
      expect(response).to have_http_status(200)
    end
  end
end
