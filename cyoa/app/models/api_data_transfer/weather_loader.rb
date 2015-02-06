require './app/models/point'
require './app/models/forecast'
require './app/models/weather_type'
require './app/models/forecast_weather_type'
require './app/models/api/weather_client'

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
      load_point_times(response, { point: point, point_index: index })
    end
  end

  def location_by_key(response, location_key)
    response.locations.select { |location| location[:location_key] == location_key }.first
  end

  def load_point_times(response, load_params = {})
    times = TimeKeyBuilder.times(response.weather_data.time_layouts)
    times.each do |key, value|
      load_params.merge({ time_key: key,
                          time_value: value })
      load_forecast(response, load_params)
    end
  end

  def load_forecast(response, load_params = {})
    forecast = Forecast.find(point_id: load_params[:point][:id],
                             forecast_type_id: load_params[:time_key][:forecast_id]
                             start_time: load_params[:time_key][:start_time],
                             end_time: load_params[:time_key][:end_time]).first
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
                 forecast_id: load_params[:time_key][:forecast_id]
                 start_time: load_params[:time_key][:start_time],
                 end_time: load_params[:time_key][:end_time],
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
    if weather_has_time?(response, load_params)
      ForecastWeatherType.destroy_all(forecast_id: load_params[:forecast][:id])
      insert_weather!(response, load_params)
    end
  end

  def get_maxt(response, load_params = {})
    indexes = maxt_time_indexes(response, load_params)
    return nil if indexes.empty?
    if indexes.count == 0
      response.weather_data.temperatures[load_params[:point_index]].maxt.value[indexes[0]].to_i
    else
      indexes.each_with_object([]) do |index, maxts|
        maxts << response.weather_data.temperatures[load_params[:point_index]].maxt.value[indexes[index]].to_i
      end.max
    end
  end

  def get_mint(response, load_params = {})
    indexes = mint_time_indexes(response, load_params)
    return nil if indexes.empty?
    if indexes.count == 0
      response.weather_data.temperatures[load_params[:point_index]].mint.value[indexes[0]].to_i
    else
      indexes.each_with_object([]) do |index, mints|
        mints << response.weather_data.temperatures[load_params[:point_index]].mint.value[indexes[index]].to_i
      end.min
    end
  end

  def get_cloud_cover(response, load_params = {})
    indexes = cloud_cover_indexes(response, load_params)
    return nil if indexes.empty?
    raise WeatherLoaderError, "Unhandled multiple cloud cover times" if indexes.count > 0
    response.weather_data.cloud_covers[load_params[:point_index]].value[indexes[0]].to_i
  end

  def get_icon_link(response, load_params = {})
    indexes = icon_link_indexes(response, load_params)
    return nil if indexes.empty?
    raise WeatherLoaderError, "Unhandled multiple icon link times" if indexes.count > 0
    response.weather_data.conditions_icons[load_params[:point_index]].icon_link[indexes[0]]
  end

  def maxt_time_indexes(response, load_params = {})
    load_params[:time_value].each_with_object([]) do |(key, value), indexes|
      layout = response.weather_data.temperatures[load_params[:point_index]].maxt.time_layout
      indexes << value if layout == key
    end
  end
  
  def mint_time_indexes(response, load_params = {})
    load_params[:time_value].each_with_object([]) do |(key, value), indexes|
      layout = response.weather_data.temperatures[load_params[:point_index]].mint.time_layout
      indexes << value if layout == key
    end
  end

  def cloud_cover_indexes(response, load_params = {})
    load_params[:time_value].each_with_object([]) do |(key, value), indexes|
      layout = response.weather_data.cloud_covers[load_params[:point_index]].time_layout
      indexes << value if layout == key
    end
  end

  def weather_time_indexes(response, load_params = {})
    load_params[:time_value].each_with_object([]) do |(key, value), indexes|
      layout = response.weather_data.weather[load_params[:point_index]].time_layout
      indexes << value if layout == key
    end
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

class WeatherLoaderError < StandardError
end