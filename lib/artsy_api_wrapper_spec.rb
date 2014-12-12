require 'rails_helper'

RSpec.describe ArtsyApiWrapper do
  let(:client_id) { '094ac11b91081fbcd043' }
  let(:client_secret) { 'a1213c1b069c9479db3728a3686a6907' }

  context "External request" do

    it 'calls the Artsy API' do
      api_instance = ArtsyApiWrapper.new(client_id: client_id, client_secret: client_secret)

      response = api_instance.token

      expect(response).to be_an_instance_of(String)
    end
  end

  context "initialize the API" do

    describe "initialize" do
      it "creates an instance of the API" do
        api_instance = ArtsyApiWrapper.new(client_id: client_id, client_secret: client_secret)

        expect(api_instance).to be_an_instance_of(ArtsyApiWrapper)
      end
    end
  end

  context "API retrieval" do
    it "retrieves json data for an artist" do
      uri = URI("https://api.artsy.net/api/artists/andy-warhol")

      response = JSON.load(Net::HTTP.get(uri))

      expect(response["name"]).to eq("Andy Warhol")
    end
  end
end
