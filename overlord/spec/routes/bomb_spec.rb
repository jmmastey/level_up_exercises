require_relative '../spec_helper'
require 'timecop'

describe 'bomb' do
  let (:valid_bomb) do
    { activation_code: '12342',
      deactivation_code: '0220',
      detonation_time: '55'
    }.to_json

  end
  it 'should use default activation code if not given' do
    post '/bomb'
    json = JSON.parse(last_response.body)
    expect(json["activation_code"]).to eq ("1234")
  end

  it 'should not be activated when first booted' do
    post '/bomb'
    json = JSON.parse(last_response.body)
    expect(json["status"]).to eq ("inactive")
  end

  it 'should not use default activation code if given' do
    post '/bomb', valid_bomb
    json = JSON.parse(last_response.body)
    expect(json["activation_code"]).to eq ("12342")
  end

  context "activating the bomb" do
    before (:each) do
      Bomb.destroy_all
      Bomb.create(
      activation_code: "2345")
    end

    it "rejects the code for activation if its wrong" do
      post '/bomb/activate', {activation_code: '1234'}.to_json
      json = JSON.parse(last_response.body)
      expect(json["bomb_status"]).to eq ("inactive")
    end

    it "accepts the code for activation if its right and activated the bomb" do
      post '/bomb/activate', {activation_code: '2345'}.to_json
      json = JSON.parse(last_response.body)
      expect(json["bomb_status"]).to eq ("active")
    end

    it "explodes after the detonation_time has passed" do

      Timecop.freeze(Time.parse '2015-01-15 12:34:00') do
        post '/bomb/activate', {activation_code: '2345'}.to_json
        json = JSON.parse(last_response.body)
        expect(json["bomb_status"]).to eq ("active")
      end
      Timecop.freeze(Time.parse '2015-01-15 12:35:00') do
        get "/bomb.json"
        json = JSON.parse(last_response.body)
        expect(json["bomb_status"]).to eq ("explode")
      end
    end
  end

  context "deactivating the live bomb" do
    before do
      Bomb.destroy_all
      Bomb.create(
      deactivation_code: "0000",
      status: "active")
    end

    it "rejects the code for deactivation if its wrong" do
      post '/bomb/deactivate', {deactivation_code: '1234'}.to_json
      json = JSON.parse(last_response.body)
      expect(json["bomb_status"]).to eq ("active")
    end

    it "accepts the code for deactivation if its correct" do
      post '/bomb/deactivate', {deactivation_code: '0000'}.to_json
      json = JSON.parse(last_response.body)
      expect(json["bomb_status"]).to eq ("inactive")
    end
  end

  context "the bomb has exploded" do
    before do
      Bomb.destroy_all
      Bomb.create(
      deactivation_code: "0000",
      activation_code: "1234",
      status: "explode")
    end

    it "doesn't deactivate if bomb is exploded" do
      post '/bomb/deactivate', {deactivation_code: '0000'}.to_json
      json = JSON.parse(last_response.body)
      expect(json["bomb_status"]).to eq ("explode")
    end

    it "doesn't activate if bomb is exploded" do
      post '/bomb/activate', {deactivation_code: '1234'}.to_json
      json = JSON.parse(last_response.body)
      expect(json["bomb_status"]).to eq ("explode")
    end
  end
end