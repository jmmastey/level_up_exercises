require_relative "param_mapping"
module EveCentral
  class Marketstat
    include ParamMapping

    def lookup(item_id, options = {})
      endpoint = "http://api.eve-central.com/api/marketstat"
      params = create_params(item_id, options)
      response = send_request(url, data)
      format_response(response)
    end

    private

    PARAM_MAPPER = {
      hours: :hours,
      item_id: :typeid,
      min_qty: :minQ,
      regions: :regionlimit,
      system: :usesystem
    }

    def create_params(item_id, options)
      options[:item_id] = item_id
      mapped_params = map_params(options, PARAM_MAPPER)
      create_post_params(mapped_params)
    end

    def format_response(response)

    end

    def send_request(url, data)
      Net::HTTP.post(url, data)
    end
  end
end
