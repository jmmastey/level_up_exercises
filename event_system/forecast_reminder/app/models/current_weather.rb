class CurrentWeather < ActiveRecord::Base
  validates :station_id, uniqueness: true

  def self.update_or_create_from_hash(observation)
    station_id = observation["station_id"]
    find_or_create_by(station_id: station_id).update(
      temperature: observation["temp_f"],
      condition: observation["weather"],
      location_name: observation["location"],
      observation_time: observation["observation_time"],
      wind: "#{observation["wind_dir"]} #{observation["wind_mph"]} mph",
      pressure: observation["pressure_in"],
      dew_point: observation["dewpoint_f"],
      wind_chill: observation["windchill_f"],
      visibility: observation["visibility_mi"],
      humidity: observation["relative_humidity"],
      icon_url: "#{observation["icon_url_base"]}" \
        "#{observation["icon_url_name"]}",
      history_url: observation["two_day_history_url"]
    )
  end
end
