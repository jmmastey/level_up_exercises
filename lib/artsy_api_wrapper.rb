require 'hyperclient'

class ArtsyApiWrapper
  # attr_reader :api, :token

  def initialize(client_id:, client_secret:)
    @token = get_token(client_id, client_secret)
    @api = request_api
  end

  # def request_api
  #   Hyperclient.new('https://api.artsy.net/api') do |api|
  #     api.headers['Accept'] = 'application/vnd.artsy-v2+json'
  #     api.headers['X-Xapp-Token'] = @token
  #   end
  # end

  # def get_artist(name:)
  #   api.artist(id: name)
  # end

  def artist_url

  end

  private

  def get_token(client_id, client_secret)
    api = Hyperclient.new('https://api.artsy.net/api') do |api|
      api.headers['Accept'] = 'application/vnd.artsy-v2+json'
    end
    api.tokens.xapp_token._post(client_id: client_id, client_secret: client_secret).token
  end
end

# client_id = '094ac11b91081fbcd043'
# client_secret = 'a1213c1b069c9479db3728a3686a6907'
# new_api = ArtsyApiWrapper.new(client_id: client_id, client_secret: client_secret)
# #puts new_api.token
# puts new_api.get_artist(name: 'andy-warhol').name

#
