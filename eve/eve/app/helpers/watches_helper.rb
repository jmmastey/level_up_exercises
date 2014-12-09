module WatchesHelper
  def tab_class(watch, tab_name)
    return :active if visible_location_type(watch) == tab_name
    ""
  end

  private

  def visible_location_type(watch)
    return :region if watch.region.present?
    return :station if watch.station.present?
    nil
  end
end
