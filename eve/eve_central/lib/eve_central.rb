require "eve_central/version"

class EveCentral
  def marketstat(item_id, options = {})
    endpoint = "http://api.eve-central.com/api/marketstat"
    params = create_marketstat_params(item_id, options)
  end

  def quicklook(item_id, options = {})
    endpoint = "http://api.eve-central.com/api/quicklook"
    params = create_quicklook_params(item_id, options)
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

  def create_post_param(key, value)
    return "#{key}=#{value}" unless value.is_a?(Enumerable)

    value.map { |v| create_post_param(key, value) }
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
    Hash[params.map { |key, value| [mapper[key] || key, value] }]
  end

  def send_post_request(url, data)
    response = Net::HTTP.post(url, data)
  end
end
