require "faraday"
require "json"

module Locu
  class Client
    FIELDS = %w(
      locu_id name description location contact categories menus website_url
    )

    HOST = "https://api.locu.com"
    PATHS = { venue_search: "/v2/venue/search" }

    def initialize(api_key)
      @api_key = api_key
      @client = Faraday.new(HOST)
    end

    def search_venues(venue_params = {})
      params = default_params.merge(fields: FIELDS,
                                    venue_queries: [venue_params])

      post_json(PATHS[:venue_search], params)
    end

    private

    def post_json(path, params)
      response = @client.post do |req|
        req.url(path)
        req.headers["Content-Type"] = "application/json"
        req.body = params.to_json
      end

      parse_json(response.body)
    end

    def default_params
      { api_key: @api_key }
    end

    def parse_json(body)
      return unless body

      JSON.parse(body)
    rescue JSON::ParserError
      raise "Unable to parse result from Locu."
    end
  end
end
