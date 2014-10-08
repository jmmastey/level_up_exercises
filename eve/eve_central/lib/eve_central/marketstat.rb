require_relative "param_mapping"
module EveCentral
  class Marketstat
    DEFAULT_URL = "http://api.eve-central.com/api/marketstat"

    attr_reader :url

    def initialize(url = DEFAULT_URL)
      @url = url
    end

    def request(item_id, options = {})
      params = create_params(item_id, options)
      response = send_request(data)
      format_response(response)
    end

    private

    PARAM_MAPPER = {
      hours: "hours",
      item_id: "typeid",
      min_qty: "minQ",
      regions: "regionlimit",
      system: "usesystem"
    }

    def create_params(item_id, options)
      options[:item_id] = item_id
    end

    def map_params(options, mapper)
      params = options.map do |key, value|
        key = PARAM_MAPPER[key] || key.to_s
        [key, value]
      end

      Hash[options]
    end

    def format_response(response)
      raise_conn_error(response.code) if response.code != 200

      # TODO: format response
      raise NotImplementedError
    end

    def raise_conn_error(code)
      message = "Unable to connect to API at '#{url}'. Code #{code}"
      raise ConnectionError, message
    end

    def send_request(data)
      Net::HTTP.post_form(URI(url), data)
    end
  end
end
