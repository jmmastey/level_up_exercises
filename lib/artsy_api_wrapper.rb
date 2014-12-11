require 'hyperclient'

class ArtsyApiWrapper
  attr_reader :artsy_api

  def initialize(client_id:, client_secret:)
    @artsy_api = set_up_api(client_id, client_secret)
    @client_id = client_id
    @client_secret = client_secret
    #@xapp_token = @api.api.tokens.xapp_token._post(client_id: client_id, client_secret: client_secret).token
  end

  def set_up_api(client_id, client_secret)
    Hyperclient.new('https://api.artsy.net/api') do |api|
      api.headers['Accept'] = 'application/vnd.artsy-v2+json'
    end
  end

  def get_artist(name:)
    artsy_api.artist(id: name)
  end

  private

  def token
    artsy_api.tokens.xapp_token._post(client_id: @client_id, client_secret: @client_secret).token
  end
end

client_id = '094ac11b91081fbcd043'
client_secret = 'a1213c1b069c9479db3728a3686a6907'
new_api = ArtsyApiWrapper.new(client_id: client_id, client_secret: client_secret)
puts new_api.artsy_api.tokens.xapp_token._post(client_id: client_id, client_secret: client_secret).token

puts new_api.get_artist(name: 'andy-warhol')

