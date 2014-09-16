# File overlord_spec.rb
require File.expand_path '../spec_helper.rb', __FILE__
include Sinatra::BombHelpers


describe 'Overlord' do

  it 'should allow accessing the home page' do
    get '/'
    expect(last_response).to be_ok
  end

  context 'bomb api' do
    after do
      Bomb.all.destroy!
      Wire.all.destroy!
    end
    let(:bomb_body) { { activation_code: '12342', deactivation_code: '0220', detonation_time: '55' }.to_json }
    let(:bomb_body_default) { { detonation_time: '55' }.to_json }
    let(:bomb_body_failure) { {activation_code: 12342, deactivation_code: 0220, detonation_time: 55 }.to_json }
    it 'should have no bombs', type: :request do
      get '/api/bomb/list'
      expect(last_response).to be_ok
      expect(array).to be_empty
    end

    it 'should create a bomb with wires' do
      post '/api/bomb', bomb_body
      expect(last_response).to be_successful
      expect(json).to have_key(:status).and have_key(:id)
    end

    it 'should create a default bomb' do
      post '/api/bomb', bomb_body_default
      expect(last_response).to be_successful
      expect(json).to have_key(:status).and have_key(:id)
    end

    it 'should not create a bomb' do
      post '/api/bomb', bomb_body_failure
      expect(last_response).to be_client_error
    end

    context 'with bombs' do
      let!(:bomb) { Bomb.create(activation_code: '1234',
                                deactivation_code: '0000',
                                detonation_time: '60',
                                wires: create_wires(5)) }

      it 'should have a list' do
        get '/api/bomb/list'
        expect(last_response).to be_ok
        expect(array).not_to be_empty
        array.each do |bomb_listing|
          expect(bomb_listing.symbolize_keys!).to have_key(:status).and have_key(:id)
        end

      end

      context 'with codes' do
        context 'activation' do
          it 'should activate bomb' do
            get "/api/bomb/#{bomb.id}/activate/#{bomb.activation_code}"
            expect(last_response).to be_ok
            expect(json[:status]).to eq('active')
          end

          it 'should not activate bomb' do
            get "/api/bomb/#{bomb.id}/activate/ADFFF"
            expect(last_response).to be_bad_request
            expect(json).to have_key(:error)
            expect(json[:error]).to eq('Invalid Activation Code')
          end
        end
        context 'deactivation' do
          let!(:bomb) { Bomb.create(activation_code: '1234',
                                    deactivation_code: '0000',
                                    detonation_time: '55',
                                    wires: create_wires(5), status: :active) }
          it 'should deactivate bomb' do
            get "/api/bomb/#{bomb.id}/deactivate/#{bomb.deactivation_code}"
            expect(last_response).to be_ok
            expect(json[:status]).to eq('inactive')
          end

          it 'should not deactivate bomb and increase attempts' do
            get "/api/bomb/#{bomb.id}/deactivate/ADFFF"
            expect(last_response).to be_bad_request
            expect(json).to have_key(:error)
            expect(json[:attempts]).to eq(1)
            expect(json[:error]).to eq('Invalid Deactivation Code')
          end

          it 'should explode with 3 wrong attempts' do
            get "/api/bomb/#{bomb.id}/deactivate/ADFFF"
            get "/api/bomb/#{bomb.id}/deactivate/ADFFF"
            get "/api/bomb/#{bomb.id}/deactivate/ADFFF"
            expect(last_response).to be_ok
            expect(json).to have_key(:status)
            expect(json[:attempts]).to eq(3)
            expect(json[:status]).to eq('exploded')
          end
        end

      end

      context 'has wires' do
        it 'should have id' do
          get "/api/bomb/#{bomb.id}"
          expect(last_response).to be_ok
          expect(json).to have_key(:id)
                          .and have_key(:wires)
                               .and satisfy { |bomb2| bomb2[:wires].size >= 4 }
          expect(json[:id]).to eq(bomb.id)
        end

        it 'cuts non-existent wire' do
          get "/api/bomb/cut/#{bomb.id.to_s}/avsbs"
          expect(last_response).to be_not_found
        end

        it 'cuts each wire' do
          messages = []
          bomb.wires.each do |wire|
            get "/api/bomb/cut/#{bomb.id.to_s}/#{wire.id}"
            messages << json[:message]
            expect(last_response).to be_ok
            expect(json).to have_key(:status).and have_key(:message)
          end
          expect(messages).to be
          expect(messages.size).to be >= 3
        end


      end

    end
  end
end
