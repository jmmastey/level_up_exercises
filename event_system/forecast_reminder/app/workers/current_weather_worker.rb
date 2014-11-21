require 'rest-client'

class CurrentWeatherWorker
  include Sidekiq::Worker

  BASE_URL = 'http://w1.weather.gov/xml/current_obs/'

  def perform(station_id = nil)
    locations = Array.wrap(station_id || Location.stations)
    locations.each { |station| save(station_data(station), station) }
  end

  private

  def save(current_observation, station_id)
    return unless current_observation
    CurrentWeather.update_or_create_from_hash(current_observation)
  rescue => e
    logger.warn("Failed to save data for station id #{station_id} " \
                "with status #{e.message}")
  end

  def station_data(station_id)
    data = raw_data(station_id)
    Hash.from_xml(data)["current_observation"]
  rescue => e
    logger.warn("Failed to get data for station id #{station_id} " \
                "with status #{e.message}")
    nil
  end

  def raw_data(station_id)
    RestClient.get("#{BASE_URL}#{station_id}.xml")
  end
end
