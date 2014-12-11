require 'artsy_api_wrapper'

RSpec.describe ArtsyApiWrapper do
  let(:client_id) { '094ac11b91081fbcd043' }
  let(:client_secret) { 'a1213c1b069c9479db3728a3686a6907' }
  let(:api_instance) { ArtsyApiWrapper.new(client_id: :client_id, client_secret: :client_secret) }

  context "External request" do
    it 'calls the Artsy API' do
      response = api_instance.api.tokens.xapp_token._post(client_id: client_id, client_secret: client_secret).token

      expect(response).to be_an_instance_of(String)
    end
  end

  context "initialize the API" do

    describe "initialize" do
      it "creates an instance of the API" do
        expect(api_instance).to be_an_instance_of(ArtsyApiWrapper)
      end
    end
  end
end
