# File overlord_spec.rb
require File.expand_path '../spec_helper.rb', __FILE__

describe 'Overlord' do

  it 'should allow accessing the home page' do
    get '/'
    expect(last_response).to be_ok
  end

  context 'bomb api' do
    after {Bomb.all.destroy!}
    let(:bomb_body) {{ activation_code: '12342', deactivation_code: '0220', detonation_time: '2014-09-08 00:01:00 -0500' }.to_json}
    it 'should have no bombs' do
      get '/api/bomb'
      expect(last_response).to be_ok
      expect(last_response.body).to eq('[]')
    end

    it 'should create a bomb with wires' do
      response_message = {status: 'ok'}
      post '/api/bomb', bomb_body
      expect(last_response.body).to eq(response_message.to_json)
    end

    context 'with bombs' do
        let!(:bomb) {Bomb.create(activation_code:    1234,
                           deactivation_code: 0000,
                           detonation_time: Time.now,
                           wires: create_wires(4))}
      end

      it 'should have a bomb' do
        get '/api/bomb'
        expect(last_response).to be_ok
        expect(last_response.body).to eq('[]')
    end
  end
end
