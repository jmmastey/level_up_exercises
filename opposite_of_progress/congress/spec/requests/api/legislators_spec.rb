require 'spec_helper'

describe "Legislators API", :type => :request do
  it "retrieves the data of a specific legislator" do
    legislator = FactoryGirl.create(:legislator)
    get "/legislators/#{legislator.id}.json"
    expect(response).to be_success
  end
end