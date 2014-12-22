require "net/http"
require "nokogiri"
require_relative "errors"
require_relative "order"
require_relative "xml_helpers"

module EveCentral
  class Quicklook
    include XmlHelpers

    DEFAULT_URL = "http://api.eve-central.com/api/quicklook"

    PARAM_KEY_MAP = {
      hours: "sethours",
      item_id: "typeid",
      min_qty: "setminQ",
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

    def convert_item(quicklook_node)
      Item.new(get_node_int(quicklook_node, "item"),
               get_node_content(quicklook_node, "itemname"))
    end

    def convert_order(order_node)
      Order.new(expires: get_node_date(order_node, "expires"),
                id: order_node["id"].to_i,
                min_volume: get_node_int(order_node, "min_volume"),
                price: get_node_float(order_node, "price"),
                region_id: get_node_int(order_node, "region"),
                security: get_node_float(order_node, "security"),
                station_id: get_node_int(order_node, "station"),
                station_name: get_node_content(order_node, "station_name"),
                volume_remaining: get_node_int(order_node, "vol_remain"))
    end

    def convert_orders(order_nodes)
      order_nodes.map do |order_node|
        convert_order(order_node)
      end
    end

    def convert_quicklook_item(quicklook_node)
      buy_nodes = quicklook_node.xpath("buy_orders/order")
      sell_nodes = quicklook_node.xpath("sell_orders/order")
      QuicklookItem.new(item: convert_item(quicklook_node),
                        buy_orders: convert_orders(buy_nodes),
                        sell_orders: convert_orders(sell_nodes))
    end

    def convert_response(response)
      raise_conn_error(response.code) if response.code != "200"
      response_body = Nokogiri::XML(response.body)
      ql_node = response_body.xpath("/evec_api/quicklook")
      convert_quicklook_item(ql_node)
    end

    def create_params(item_id, options)
      options[:item_id] = item_id
      map_params(options)
    end

    def map_params(options)
      params = options.map do |key, value|
        key = PARAM_KEY_MAP[key] || key.to_s
        [key, value]
      end

      Hash[params]
    end

    def raise_conn_error(code)
      message = "Unable to connect to Marketstat API at '#{url}'. Code #{code}"
      raise ConnectionError, message
    end

    def send_request(data)
      Net::HTTP.post_form(URI(url), data)
    end
  end
end
