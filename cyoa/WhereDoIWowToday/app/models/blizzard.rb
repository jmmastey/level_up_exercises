require 'uri'

class Blizzard
  include HTTParty
  base_uri 'https://us.api.battle.net/wow'

  MAX_QUERIES_BLIZZARD_PERMITS_PER_SECOND = 10
  
  def initialize(api_key: nil)
    api_key = ENV['API_KEY'] if api_key.nil?
    @options = { query: { apikey: api_key } }
  end

  def get_character(name, realm)
    name = URI.escape(name)
    realm = URI.escape(realm)
    get "/character/#{realm}/#{name}"
  end

  def get_character_quests(name, realm)
    name = URI.escape(name)
    realm = URI.escape(realm)
    get "/character/#{realm}/#{name}?fields=quests"
  end

  def get_quest(id)
    get "/quest/#{id}"
  end

  private

  def get(partial_url)
    sleep 1.0 / MAX_QUERIES_BLIZZARD_PERMITS_PER_SECOND

    result = self.class.get partial_url, @options
    return if result.code != 200 || result.body.nil?
    JSON.parse(result.body)
  end
end
