require 'rails_helper'

RSpec.describe HomeController, :type => :controller do

  describe "GET 'trending'" do
    it "returns http success" do
      get 'trending'
      expect(response).to be_success
    end
  end

end
