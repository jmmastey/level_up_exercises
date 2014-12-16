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

#puts Rails.application.secrets.artsy_key
# client_id = '094ac11b91081fbcd043'
# client_secret = 'a1213c1b069c9479db3728a3686a6907'
# new_api = ArtsyApiWrapper.new(client_id: client_id, client_secret: client_secret)
# #puts new_api.token
# puts new_api.get_artist(name: 'andy-warhol').name

# client_id = '094ac11b91081fbcd043'
# client_secret = 'a1213c1b069c9479db3728a3686a6907'

# api = Hyperclient.new('https://api.artsy.net/api') do |api|
#   api.headers['Accept'] = 'application/vnd.artsy-v2+json'
# end

# xapp_token = 'JvTPWe4WsQO-xqX6Bts49nAYOClaICMrVslCpuIQHvBO7wSjcDB3LCczltV67h8nsZRsjWmQY0ZiQUjFazSwamrazFul1pItKFjG2EUxwTIBBKx29wyASO_ViyxdqMu7qcJpvuLe_ZpjMwZiBC6kXEIynyxI3T584Qg6AjhcT9G0IsGvn6Yxh7toqORqkHrztLU698MgMGQfZP556L6q7gEwLDrUaSm9A4WLp-FjmI8='

# api = Hyperclient.new('https://api.artsy.net/api') do |api|
#   api.headers['Accept'] = 'application/vnd.artsy-v2+json'
#   api.headers['X-Xapp-Token'] = xapp_token
# end


# andy_warhol = api.artist(id: 'andy-warhol')
# puts "#{andy_warhol.name} was born in #{andy_warhol.birthday} in #{andy_warhol.hometown}"


