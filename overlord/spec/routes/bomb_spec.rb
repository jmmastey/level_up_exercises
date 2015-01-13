require_relative '../spec_helper'

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
end