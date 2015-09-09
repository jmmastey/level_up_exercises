class Blizzard
  include HTTParty
  base_uri 'https://us.api.battle.net/wow'

  def initialize(api_key: nil)
    api_key = ENV['API_KEY'] if api_key.nil?
    @options = { query: { apikey: api_key } }
  end
end
