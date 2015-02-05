require './app/models/point'
require './app/models/forecast'
require './app/models/weather_type'
require './app/models/forecast_weather_type'
require './app/models/api/weather_client'
require 'active_support/all'

module WeatherLoader
  def load(inputs = {})
    response = requester.new.request(inputs)
    load_points(response)
  end

  private

  def load_points(response)
    response.weather_data.applicable_locations.each_with_index do |location_key, index|
      location = location_by_key(response, location_key)
      point = Point.where(lat: location.latitude, lon: location.longitude).first
      load_point_time_layouts(response, index, point)
    end
  end

  def location_by_key(response, location_key)
    response.locations.select { |location| location[:location_key] == location_key }.first
  end

  def load_point_time_layouts(response, point_index, point)
    response.time_layouts.each do |time_layout|
      time_layout.start_valid_time.each_with_index do |start_valid_time, time_index|
        end_valid_time = end_time_for_start_time(time_layout, start_valid_time, time_index)
        load_forecast(response, { point: point,
                                  point_index: point_index,
                                  time_layout: time_layout,
                                  start_valid_time: start_valid_time,
                                  end_valid_time: end_valid_time,
                                  time_index: time_index })
      end
    end
  end

  def end_time_for_start_time(time_layout, start_valid_time, index)
    return time_layout.end_valid_time[index] unless time_layout.end_valid_time[index].nil?
    start_valid_time + layout_key_hour_interval.hours
  end

  def layout_key_hour_interval(layout_key)
    layout_key.split("-")[1].split("p")[1].split("h")[0]
  end

  def load_forecast(response, load_params = {})
    forecast = Forecast.find(point_id: load_params[:point][:id],
                             start_time: load_params[:start_valid_time],
                             end_time: load_params[:end_valid_time]).first
    if forecast.empty?
      insert_forecast(response, load_params)
    else
      load_params[:forecast] = forecast
      update_forecast(response, load_params)
    end
  end

  def insert_forecast(response, load_params = {})
    load_params.merge(get_forecast_params(response, load_params))
    Forecast.new(point_id: load_params[:point][:id],
                 start_time: load_params[:start_valid_time],
                 end_time: load_params[:end_valid_time],
                 maxt: load_params[:maxt],
                 mint: load_params[:mint],
                 cloud_cover: load_params[:cloud_cover],
                 icon_link: load_params[:icon_link]).save!
    add_forecast_weather!(response, load_params)
  end

  def update_forecast(response, load_params = {})
    load_params.merge(get_forecast_params(response, load_params))
    load_params[:forecast].update(maxt: load_params[:maxt],
                                  mint: load_params[:mint],
                                  cloud_cover: load_params[:cloud_cover],
                                  icon_link: load_params[:icon_link])
    add_forecast_weather!(response, load_params)
  end

  def get_forecast_params(response, load_params = {})
    forecast_params = {}
    forecast_params[:maxt] = get_maxt(response, load_params)
    forecast_params[:mint] = get_mint(response, load_params)
    forecast_params[:cloud_cover] = get_cloud_cover(response, load_params)
    forecast_params[:icon_link] = get_icon_link(response, load_params)
  end

  def add_forecast_weather!(response, load_params)
    if weather_matches_layout?(response, load_params)
      ForecastWeatherType.destroy_all(forecast_id: load_params[:forecast][:id])
      insert_weather!(response, load_params)
    end
  end

  def get_maxt(response, load_params = {})
    return nil unless maxt_matches_layout?(response, load_params)
    response.weather_data.temperatures[load_params[:point_index]].maxt.value[:time_index].to_i
  end

  def get_mint(response, load_params = {})
    return nil unless mint_matches_layout?(response, load_params)
    response.weather_data.temperatures[load_params[:point_index]].mint.value[:time_index].to_i
  end

  def get_cloud_cover(response, load_params = {})
    return nil unless cloud_cover_matches_layout?(response, load_params)
    response.weather_data.cloud_covers[load_params[:point_index]].value[:time_index].to_i
  end

  def get_icon_link(response, load_params = {})
    return nil unless icon_link_matches_layout?(response, load_params)
    response.weather_data.conditions_icons[load_params[:point_index]].icon_link[:time_index]
  end

  def weather_matches_layout(response, load_params = {})
    response.weather_data.weather[load_params[:point_index]].time_layout == load_params[:time_layout]
  end

  def maxt_matches_layout(response, load_params = {})
    response.weather_data.temperatures[load_params[:point_index]].maxt.time_layout == load_params[:time_layout]
  end

  def mint_matches_layout(response, load_params = {})
    response.weather_data.temperatures[load_params[:point_index]].mint.time_layout == load_params[:time_layout]
  end

  def cloud_cover_matches_layout(response, load_params = {})
    response.weather_data.cloud_covers[load_params[:point_index]].time_layout == load_params[:time_layout]
  end

  def icon_link_matches_layout(response, load_params = {})
    response.weather_data.conditions_icons[load_params[:point_index]].time_layout == load_params[:time_layout]
  end

  def param_matches_layout(response, load_params = {}, param)
    response.weather_data.send(param)[load_params[:point_index]].time_layout == load_params[:time_layout]
  end

  def insert_weather!(response, load_params = {})
    weather_condition = response.weather_data
                                .weather[load_params[:point_index]]
                                .weather_conditions[load_params[:time_index]]
    unless weather_condition.nil?
      weather_condition.weather_types.each_with_index do |weather_type, wt_index|
        weather_type_id = insert_or_return_weather_type_id!(weather_type)
        additive = weather_condition.additives[wt_index]
        coverage = weather_condition.coverages[wt_index]
        qualifier = weather_condition.qualifiers[wt_index]
        ForecastWeatherType.new(forecast_id: load_params[:forecast][:id],
                                weather_type_id: weather_type_id,
                                additive: additive,
                                coverage: coverage,
                                qualifier: qualifier).save!
      end
    end
  end

  def insert_or_return_weather_type_id!(weather_type)
    row = WeatherType.find(weather_type: weather_type).first
    if row.empty?
      WeatherType.new(weather_type: weather_type).save!
    else
      row[:id]
    end
  end

  def requester
    WeatherClient
  end
end