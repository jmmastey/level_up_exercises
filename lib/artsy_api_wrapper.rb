require 'hyperclient'

class ArtsyApiWrapper
  def self.get_artist(artist_name)
    api_access = make_connection
    api_access.artist(id: artist_name)._response.body
  end

  def self.make_connection
    Hyperclient.new('https://api.artsy.net/api') do |api|
      api.headers['Accept'] = 'application/vnd.artsy-v2+json'
      api.headers['X-Xapp-Token'] = Rails.application.secrets.artsy_key
    end
  end
end
