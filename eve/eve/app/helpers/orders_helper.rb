module OrdersHelper
  def order_query_tab_class(region, station, tab_name)
    return :active if order_visible_location_type(region, station) == tab_name
    ""
  end

  private

  def order_visible_location_type(region, station)
    return :region if region.present?
    return :station if station.present?
    nil
  end
end
