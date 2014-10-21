require 'rails_helper'

RSpec.describe "Watches", :type => :request do
  describe "GET /watches" do
    it "works! (now write some real specs)" do
      get watches_path
      expect(response.status).to be(200)
    end
  end
end
