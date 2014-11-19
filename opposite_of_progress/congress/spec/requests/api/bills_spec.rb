require 'spec_helper'

describe "Bills API", :type => :request do
  it "retrieves the data of a specific bill" do
    bill = FactoryGirl.create(:bill)
    get "/bills/#{bill.id}.json"
    expect(response).to be_success
  end
end