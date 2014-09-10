# File request_helpers.rb

module Requests
  module JsonHelpers
    def json
      @json ||= JSON.parse(last_response.body).symbolize_keys!
    end

    def array
      @array ||= JSON.parse(last_response.body)
    end
  end
end