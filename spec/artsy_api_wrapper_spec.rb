require 'rails_helper'
require 'support/data_files/sample_api_data'

RSpec.describe ArtsyApiWrapper do

  let(:json_data_for_artist)  { SampleData::RESPONSE }
  let(:artist_name) { "andy-warhol"}

  before do
    stub_request(:get, "https://api.artsy.net/api").
       with(:headers => {'Accept'=>'application/vnd.artsy-v2+json', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Content-Type'=>'application/json', 'User-Agent'=>'Faraday v0.9.0', 'X-Xapp-Token'=>'JvTPWe4WsQO-xqX6Bts49nAYOClaICMrVslCpuIQHvBO7wSjcDB3LCczltV67h8nsZRsjWmQY0ZiQUjFazSwamrazFul1pItKFjG2EUxwTIBBKx29wyASO_ViyxdqMu7qcJpvuLe_ZpjMwZiBC6kXEIynyxI3T584Qg6AjhcT9G0IsGvn6Yxh7toqORqkHrztLU698MgMGQfZP556L6q7gEwLDrUaSm9A4WLp-FjmI8='}).
       to_return(:status => 200, :body => "", :headers => {})

     allow(ArtsyApiWrapper).to receive(:get_artist).with('andy-warhol').and_return(json_data_for_artist)
  end

  describe ".get_artist_json_data" do
    it "returns json data for the artist" do
      expect(ArtsyApiWrapper.get_artist(artist_name)).to include("updated_at")
    end
  end

  describe ".get_artist" do
    it "returns a hash of artist parameters when provided a JSON file" do
      json_data = ArtsyApiWrapper.get_artist(artist_name)

      expect(json_data["name"]).to eq("Andy Warhol")
      expect(json_data["updated_at"]).to eq("2014-12-15T17:37:32+00:00")
    end
  end
end
