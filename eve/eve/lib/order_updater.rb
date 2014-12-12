require "eve_central"

module OrderUpdater
  def update(item)
    api_result = api_client.request(item.in_game_id)
    build_orders(api_result)
  end

  private

  def api_client
    @api_client ||= EveCentral::Quicklook.new
  end

  def build_orders(api_result)
    item_id = api_result.item.id
    regions, stations = pull_locations(api_result)
    buy_orders = convert_orders(api_result.buy_orders, "buy")
    sell_orders = convert_orders(api_result.sell_orders, "sell")

    buy_orders.concat(sell_orders).flatten
  end

  def convert_order(item_id, api_order, order_type)
    Order.new(in_game_id: api_order.id,
              security: api_order.security,
              price: api_order.price,
              type: order_type,
              expires: Date.parse(api_order.expires),
              date_pulled: DateTime.now.utc,
              region: Region.find(in_game_id: api_order.region_id),
              station: Station.find(in_game_id: api_order.station.id),
              item: Item.find(in_game_id: item_id))
  end

  def convert_orders(item_id, api_orders, order_type)
    api_orders.map do |api_order|
      convert_order(item_id, api_order, order_type)
    end
  end
end
