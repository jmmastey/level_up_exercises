require 'rest-client'

class CurrentWeatherWorker
  include Sidekiq::Worker

  URL = 'http://w1.weather.gov/xml/current_obs/'

  def perform
    Location.stations.each { |station| save(station_data(station)) }
  end

  private

  def station_data(station_id)
    data = raw_data(station_id)
    Nokogiri::XML(data) if data.include?('current_observation')
  rescue => e
    logger.warn("Failed to get data for station id #{station_id} " \
                "with status #{e.message}")
    nil
  end

  def raw_data(station_id)
    RestClient.get("#{URL}#{station_id}.xml")
  end

  def save(xml)
    return unless xml
    CurrentWeather.find_or_create_from_xml(xml).save
  end
end
