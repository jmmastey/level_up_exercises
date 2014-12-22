require "spec_helper"
require_relative APP_PATH + "/overlord"

RSpec.describe Overlord do
  def app
    Overlord
  end

  describe "create bomb" do
    it "lets you create a bomb on the homepage" do
      get "/"
      expect(last_response.status).to eq 200
    end
  end
end
