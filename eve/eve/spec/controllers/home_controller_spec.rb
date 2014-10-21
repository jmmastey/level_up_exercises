require 'rails_helper'

RSpec.describe HomeController, :type => :controller do

  describe "GET index" do
    context "when not logged in" do
      it "should load the index template" do
        pending
      end
    end

    context "when logged in" do
      it "should redirect to the dashboard" do
        pending
      end
    end
  end

end
