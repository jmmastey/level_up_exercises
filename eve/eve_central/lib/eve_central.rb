require "eve_central/version"

# TODO: Separate each API method into its own class

class EveCentral
  def marketstat(item_id, options = {})
    endpoint = "http://api.eve-central.com/api/marketstat"
    params = create_marketstat_params(item_id, options)
    response = send_post_request(endpoint, params)
    create_hash_from_response(response)
  end

  def quicklook(item_id, options = {})
    endpoint = "http://api.eve-central.com/api/quicklook"
    params = create_quicklook_params(item_id, options)
    response = send_post_request(endpoint, params)
    create_hash_from_response(response)
  end

  private

  MARKETSTAT_PARAM_MAPPER = {
    hours: :hours,
    item_id: :typeid,
    min_qty: :minQ,
    regions: :regionlimit,
    system: :usesystem
  }

  QUICKLOOK_PARAM_MAPPER = {
    item_id: :typeid,
    hours: :sethours,
    regions: :regionlimit,
    system: :usesystem,
    min_qty: :setminQ
  }

  def create_hash_from_response(response)
    return nil unless response.body_permitted?

    # TODO: Implement response parser
    raise NotImplementedError, "Method not yet implemented."
  end

  def create_post_param(key, value)
    return "#{key}=#{value}" unless value.is_a?(Enumerable)

    value.map { |element| create_post_param(key, element) }
         .join("&")
  end

  def create_post_params(data)
    data.map { |key, value| create_post_param(key, value) }
        .join("&")
  end

  def create_marketstat_params(item_id, options)
    options[:item_id] = item_id
    mapped_params = map_params(options, MARKETSTAT_PARAM_MAPPER)
    create_post_params(mapped_params)
  end

  def create_quicklook_params(item_id, options)
    options[:item_id] = item_id
    mapped_params = map_params(options, QUICKLOOK_PARAM_MAPPER)
    create_post_params(mapped_params)
  end

  def map_params(params, mapper)
    mapped_params = params.map do |key, value|
      mapped_key = mapper[key] || key
      [mapped_key, value]
    end

    Hash[mapped_params]
  end

  def send_post_request(url, data)
    Net::HTTP.post(url, data)
  end
end
