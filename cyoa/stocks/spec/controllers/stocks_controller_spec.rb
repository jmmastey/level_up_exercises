require 'rails_helper'

def mock_stocks
  FactoryGirl.create(:stock, symbol: "AAPL")
  FactoryGirl.create(:stock, symbol: "MSFT")
  FactoryGirl.create(:stock, symbol: "TSLA")
end

RSpec.describe StocksController do
  context "No stocks exist" do
    describe "GET index" do
      it "doesnt populate stocks" do
        get :index
        expect(assigns(:stocks)).to be_empty
      end
    end

    describe "GET show" do
      it "raises an error if the stock does not exist" do
        expect { get :stocks, id: "FAKE" }.to raise_error
      end
    end
  end

  context "stocks are populated" do
    before(:each) do
      mock_stocks
    end

    describe "GET index" do
      it "populates sotcks" do
        get :index
        expect(assigns(:stocks)).not_to be_empty
      end
    end

    let(:finance_response) { [ OpenStruct.new(trade_date: "2014-10-10", open: "10"),
      OpenStruct.new(trade_date: "2015-01-01", open: "15.4")] }

    describe "GET show" do
      it "gets historical data about the stock" do
        allow(YahooFinance).to receive(:historical_quotes).and_return(finance_response)
        get :show, id: Stock.first.symbol
        expect(assigns(:data)).not_to be_empty
      end
    end
  end
end