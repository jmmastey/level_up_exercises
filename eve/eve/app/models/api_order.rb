require "eve_central"

class ApiOrder
  def self.update(item, earliest_date)
    api_result = api_client.request(item.in_game_id)
    build_orders(api_result)
  end

  private

  def self.api_client
    @api_client ||= EveCentral::Quicklook.new
  end

  def self.build_orders(api_result)
    item_id = api_result.item.id
    buy_orders = convert_orders(item_id, api_result.buy_orders, "buy")
    sell_orders = convert_orders(item_id, api_result.sell_orders, "sell")

    buy_orders.concat(sell_orders).flatten
  end

  def self.convert_order(item_id, api_order, order_type)
    region = find_or_create_region(api_order.region_id)
    station = find_or_create_station(api_order.station_id, api_order.station_name)

    Order.create(in_game_id: api_order.id,
                 security: api_order.security,
                 price: api_order.price,
                 order_type: order_type,
                 expires: api_order.expires,
                 date_pulled: DateTime.now.utc,
                 region: region,
                 station: station,
                 item: Item.find_by(in_game_id: item_id))
  end

  def self.convert_orders(item_id, api_orders, order_type)
    api_orders.map do |api_order|
      convert_order(item_id, api_order, order_type)
    end
  end

  def self.find_or_create_region(region_id)
    Region.find_by(in_game_id: region_id)
  rescue ActiveRecord::RecordNotFound
    Region.create_unknown(region_id)
  end

  def self.find_or_create_station(station_id, station_name)
    Station.find_by(in_game_id: station_id)
  rescue ActiveRecord::RecordNotFound
    Station.create(in_game_id: station_id,
                   name: station_name || "Unknown Station")
  end
end
