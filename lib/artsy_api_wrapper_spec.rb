require 'rails_helper'

RSpec.describe ArtsyApiWrapper do
  let(:json_data_for_artist)  { File.read("spec/support/data_files/warhol.json") }
  let(:artist_name) { "andy-warhol"}

  before do
  stub_request(:get, "https://api.artsy.net/api").
     with(:headers => {'Accept'=>'application/vnd.artsy-v2+json', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Content-Type'=>'application/json', 'User-Agent'=>'Faraday v0.9.0', 'X-Xapp-Token'=>'JvTPWe4WsQO-xqX6Bts49nAYOClaICMrVslCpuIQHvBO7wSjcDB3LCczltV67h8nsZRsjWmQY0ZiQUjFazSwamrazFul1pItKFjG2EUxwTIBBKx29wyASO_ViyxdqMu7qcJpvuLe_ZpjMwZiBC6kXEIynyxI3T584Qg6AjhcT9G0IsGvn6Yxh7toqORqkHrztLU698MgMGQfZP556L6q7gEwLDrUaSm9A4WLp-FjmI8='}).
     to_return(:status => 200, :body => "", :headers => {})
  end

  describe ".get_artist_json_data" do
    it "returns json data for the artist" do
      allow(ArtsyApiWrapper).to receive(:get_artist_json_data).and_return(json_data_for_artist)

      expect(ArtsyApiWrapper.get_artist_json_data(artist_name)).to include("updated_at")
    end
  end

  describe ".get_artist" do
    it "returns a hash of artist parameters when provided a JSON file" do
      allow(ArtsyApiWrapper).to receive(:get_artist_json_data).and_return(json_data_for_artist)

      expect(ArtsyApiWrapper.get_artist(artist_name)["name"]).to eq("Andy Warhol")
    end
  end
end
