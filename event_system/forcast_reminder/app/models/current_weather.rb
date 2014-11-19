class CurrentWeather < ActiveRecord::Base
  validates :station_id, uniqueness: true

  def self.find_or_create_from_xml(xml)
    station_id = get_value(xml, :station_id)
    find_or_create_by(station_id: station_id).tap do |current|
      current.temperature = get_value(xml, :temp_f)
      current.condition = get_value(xml, :weather)
      current.location_name = get_value(xml, :location)
      current.observation_time = get_value(xml, :observation_time)
      current.wind = "#{get_value(xml, :wind_dir)} " \
        "#{get_value(xml, :wind_mph)} mph"
      current.pressure = get_value(xml, :pressure_in)
      current.dew_point = get_value(xml, :dewpoint_f)
      current.wind_chill = get_value(xml, :windchill_f)
      current.visibility = get_value(xml, :visibility_mi)
      current.humidity = get_value(xml, :relative_humidity)
      current.icon_url = "#{get_value(xml, :icon_url_base)}"\
        "#{get_value(xml, :icon_url_name)}"
      current.history_url = get_value(xml, :two_day_history_url)
    end
  end

  def self.get_value(xml, xml_node)
    xml.at_xpath("/current_observation/#{xml_node}").text
  rescue
    nil
  end
  private_class_method :get_value
end
