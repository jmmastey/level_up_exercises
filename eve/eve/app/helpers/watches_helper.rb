module WatchesHelper
  def display_name(watch)
    return watch.nickname unless watch.nickname.blank?

    location = watch.region || watch.station
    return "#{watch.item.name} in #{location.name}"

    "#{watch.item.name}"
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
