require 'json'
require 'pry'

class AnimeService
  include HTTParty
  base_uri 'https://hummingbird.me/api/v1'

  def search(title)
    query = parameters(query: title)
    api_call('/search/anime', query)
  end

  def find_by_id(id)
    query = parameters(id: id)
    api_call("/anime/#{id}", query)
  end

  private

  def api_call(endpoint, query)
    response = self.class.get(endpoint, query)

    JSON.parse(response.body)
  end

  def parameters(params)
    { query: params }
  end
end
