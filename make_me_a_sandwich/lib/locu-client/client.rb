require "faraday"
require "json"

module Locu
  class Client
    HOST = "https://api.locu.com/v2/"

    def initialize(api_key)
      @api_key = api_key
      @client = Faraday.new(HOST)
    end

    private

    def parse_response(response)
      return unless response

      JSON.parse(response)
    rescue JSON::ParserError
      # return nil
    end
  end
end
