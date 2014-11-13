require 'rest-client'

class CurrentWeatherWorker
  include Sidekiq::Worker

  URL = 'http://w1.weather.gov/xml/current_obs/'
  DEFAULT_STATION_ID = "KMDW"

  def perform
    stations.each { |station| save(station_data(station)) }
  end

  private

  def stations
    User.uniq.pluck(:station_id) | [DEFAULT_STATION_ID]
  end

  def station_data(station_id)
    data = raw_data(station_id)
    if data.include?('current_observation')
      Nokogiri::XML(data)
    end
  rescue => e
    logger.warn("Failed to get data for station id #{station_id} with status #{e.message}")
    nil
  end

  def raw_data(station_id)
    RestClient.get("#{URL}#{station_id}.xml")
  end

  def save(xml)
    return unless xml
    current = CurrentWeather.find_or_create_by(station_id: get_value(xml, :station_id))
    current.temperature = get_value(xml, :temp_f)
    current.condition = get_value(xml, :weather)
    current.location_name = get_value(xml, :location)
    current.observation_time = get_value(xml, :observation_time)
    current.wind = "#{get_value(xml, :wind_dir)} #{get_value(xml, :wind_mph)} mph"
    current.pressure = get_value(xml, :pressure_in)
    current.dew_point = get_value(xml, :dewpoint_f)
    current.wind_chill = get_value(xml, :windchill_f)
    current.visibility = get_value(xml, :visibility_mi)
    current.humidity = get_value(xml, :relative_humidity)
    current.icon_url = "#{get_value(xml, :icon_url_base)}#{get_value(xml, :icon_url_name)}"
    current.history_url = get_value(xml, :two_day_history_url)
    current.save
  end

  def get_value(xml, xml_node)
    xml.at_xpath("/current_observation/#{xml_node}").text
  end
end
