module WatchesHelper
  def format_watch_prices(watch)
    avg_price = watch.average_price.to_s(:rounded, precision: 2)
    max_price = watch.max_price.to_s(:rounded, precision: 2)
    min_price = watch.min_price.to_s(:rounded, precision: 2)
    "#{min_price} / #{avg_price} / #{max_price} ISK"
  end

  def tab_class(watch, tab_name)
    return :active if visible_location_type(watch) == tab_name
    ""
  end

  def watch_orders_path(watch)
    search_params = { item: watch.item,
                      region: watch.region,
                      station: watch.station }
    search_orders_path(search_params)
  end

  private

  def visible_location_type(watch)
    return :region if watch.region.present?
    return :station if watch.station.present?
    nil
  end
end
