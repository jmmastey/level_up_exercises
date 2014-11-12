require 'rest-client'

class CurrentWeatherWorker
  include Sidekiq::Worker

  URL = 'http://w1.weather.gov/xml/current_obs/'
  STATION_ID = "KMDW"

  def perform
    data = RestClient.get("#{URL}#{STATION_ID}.xml")
    if data.include?('current_observation')
      xml = Nokogiri::XML(data)
      save(xml)
    end
  end

  private=
  def save(xml)
    current = CurrentWeather.find_or_create_by(station_id: STATION_ID)
    set_attribute(current, :temperature, get_value(xml, :temp_f))
    set_attribute(current, :condition, get_value(xml, :weather))
    set_attribute(current, :location_name, get_value(xml, :location))
    set_attribute(current, :observation_time, get_value(xml, :observation_time))
    set_attribute(current, :wind, "#{get_value(xml, :wind_dir)} #{get_value(xml, :wind_mph)} mph")
    set_attribute(current, :pressure, get_value(xml, :pressure_in))
    set_attribute(current, :dew_point, get_value(xml, :dewpoint_f))
    set_attribute(current, :wind_chill, get_value(xml, :windchill_f))
    set_attribute(current, :visibility, get_value(xml, :visibility_mi))
    set_attribute(current, :humidity, get_value(xml, :relative_humidity))
    set_attribute(current, :icon_url, "#{get_value(xml, :icon_url_base)}#{get_value(xml, :icon_url_name)}")
    set_attribute(current, :history_url, get_value(xml, :two_day_history_url))
    current.save
  end

  def set_attribute(model, attribute, value)
    model.send("#{attribute}=", value)
  end
  
  def get_value(xml, xml_node)
    xml.at_xpath("/current_observation/#{xml_node}").text
  end
end
