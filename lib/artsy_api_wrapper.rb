require 'hyperclient'

class ArtsyApiWrapper
  # attr_reader :api, :token

  def self.get_artist(artist_name)
    @api_access = make_connection
    get_artist_json_data(artist_name)
  end

  def self.make_connection
    Hyperclient.new('https://api.artsy.net/api') do |api|
      api.headers['Accept'] = 'application/vnd.artsy-v2+json'
      api.headers['X-Xapp-Token'] = Rails.application.secrets.artsy_key
    end
  end

  def self.get_artist_json_data(name)
    @api_access.artist(id: name)
  end

end

# client_id = '094ac11b91081fbcd043'
# client_secret = 'a1213c1b069c9479db3728a3686a6907'
# new_api = ArtsyApiWrapper.new(client_id: client_id, client_secret: client_secret)
# #puts new_api.token
# puts new_api.get_artist(name: 'andy-warhol').name

#
