require 'json'
require 'pry'

class AnimeService
  include HTTParty
  base_uri 'https://hummingbird.me/api/v1'

  attr_accessor :query

  def search(title)
    parameters(query: title)
    api_call('/search/anime')
  end

  def find_by_id(id)
    parameters(id: id)
    api_call("/anime/#{id}")
  end

  private

  def api_call(endpoint)
    response = self.class.get(endpoint, query)

    JSON.parse(response.body)
  end

  def parameters(params)
    @query = { query: params }
  end
end
