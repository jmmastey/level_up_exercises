require "net/http"
require "nokogiri"
require "pry"
require_relative "errors"

module EveCentral
  class Marketstat
    DEFAULT_URL = "http://api.eve-central.com/api/marketstat"

    PARAM_KEY_MAP = {
      hours: "hours",
      item_id: "typeid",
      min_qty: "minQ",
      regions: "regionlimit",
      system: "usesystem"
    }

    attr_reader :url

    def initialize(url = DEFAULT_URL)
      @url = url
    end

    def request(item_id, options = {})
      params = create_params(item_id, options)
      response = send_request(params)
      convert_response(response)
    end

    private

    def convert_item(type_node)
      item_id = type_node["id"].to_i
      stats = convert_stats(type_node)

      MarketstatItem.new(item_id, stats)
    end

    def convert_response(response)
      raise_conn_error(response.code) if response.code != "200"
      response_body = Nokogiri::XML(response.body)
      response_body.xpath("/evec_api/marketstat/type").map do |type_node|
        convert_item(type_node)
      end
    end

    def convert_stat_group(stat_node)
      init_params = {
        average: get_node_float(stat_node, "avg"),
        maximum: get_node_float(stat_node, "max"),
        median: get_node_float(stat_node, "median"),
        minimum: get_node_float(stat_node, "min"),
        percentile: get_node_float(stat_node, "percentile"),
        standard_deviation: get_node_float(stat_node, "stddev"),
        volume: get_node_int(stat_node, "volume") }
      MarketstatOrderGroup.new(init_params)
    end

    def create_params(item_id, options)
      options[:item_id] = item_id
      map_params(options)
    end

    def convert_stats(type_node)
      buy_node = type_node.xpath("buy").first
      sell_node = type_node.xpath("sell").first
      all_node = type_node.xpath("all").first

      { buy_stats: convert_stat_group(buy_node),
        sell_stats: convert_stat_group(sell_node),
        all_stats: convert_stat_group(all_node) }
    end

    def get_node_content(parent, xpath)
      parent.xpath(xpath).first.content
    end

    def get_node_float(parent, xpath)
      get_node_content(parent, xpath).to_f
    end

    def get_node_int(parent, xpath)
      get_node_content(parent, xpath).to_i
    end

    def map_params(options)
      params = options.map do |key, value|
        key = PARAM_KEY_MAP[key] || key.to_s
        [key, value]
      end

      Hash[params]
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
