require 'sinatra/base'

class FakeArtsy < Sinatra::Base
  get '/api/artists/:artist' do
    json_response 200, 'warhol.json'
  end

  private

  def json_response(response_code, file_name)
    content_type :json
    status response_code
    File.open(File.dirname(__FILE__) + '/support/fixtures/' + file_name, 'rb').read
  end
end
