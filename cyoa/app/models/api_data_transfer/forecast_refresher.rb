require './app/models/forecast'
require './app/models/weather_type'
require './app/models/forecast_weather_type'

module ForecastRefresher
  def self.refresh!(response, load_params = {})
    load_params.merge!(get_forecast_params(response, load_params))
    forecast = Forecast.where(point_id: load_params[:point][:id],
                              forecast_type_id: load_params[:time_key][:forecast_type_id],
                              start_time: load_params[:time_key][:start_time],
                              end_time: load_params[:time_key][:end_time])
    if forecast.empty?
      insert_forecast(response, load_params)
    else
      load_params[:forecast] = forecast.first
      update_forecast(response, load_params)
    end
  end

  def self.insert_forecast(response, load_params = {})
    forecast = Forecast.new
    forecast.point_id = load_params[:point][:id]
    forecast.forecast_type_id = load_params[:time_key][:forecast_type_id]
    forecast.start_time = load_params[:time_key][:start_time]
    forecast.end_time = load_params[:time_key][:end_time]
    forecast.maxt = load_params[:maxt]
    forecast.mint = load_params[:mint]
    forecast.cloud_cover = load_params[:cloud_cover]
    forecast.icon_link = load_params[:icon_link]
    forecast.save!
    load_params[:forecast] = forecast
    add_forecast_weather!(response, load_params)
  end

  def self.update_forecast(response, load_params = {})
    forecast = load_params[:forecast]
    forecast.maxt = load_params[:maxt]
    forecast.mint = load_params[:mint]
    forecast.cloud_cover = load_params[:cloud_cover]
    forecast.icon_link = load_params[:icon_link]
    forecast.save!
    add_forecast_weather!(response, load_params)
  end

  def self.get_forecast_params(response, load_params = {})
    forecast_params = {}
    forecast_params[:maxt] = get_maxt(response, load_params)
    forecast_params[:mint] = get_mint(response, load_params)
    forecast_params[:cloud_cover] = get_cloud_cover(response, load_params)
    forecast_params[:icon_link] = get_icon_link(response, load_params)
    forecast_params
  end

  def self.add_forecast_weather!(response, load_params)
    indexes = param_indexes(response, load_params, response.weather_data.weather[load_params[:point_index]].time_layout)
    raise WeatherLoaderError, "Unhandled multiple weather times" if indexes.count > 1
    return false if indexes.count == 0
    ForecastWeatherType.destroy_all(forecast_id: load_params[:forecast][:id])
    load_params.merge!(indexes: indexes)
    insert_weather!(response, load_params)
  end

  def self.get_maxt(response, load_params = {})
    indexes = param_indexes(response, load_params, response.weather_data.temperatures[load_params[:point_index]].maxt.time_layout)
    return nil if indexes.empty?
    if indexes.count == 0
      response.weather_data.temperatures[load_params[:point_index]].maxt.value[indexes[0]].to_i
    else
      indexes.each_with_object([]) do |index, maxts|
        maxts << response.weather_data.temperatures[load_params[:point_index]].maxt.value[index].to_i
      end.max
    end
  end

  def self.get_mint(response, load_params = {})
    indexes = param_indexes(response, load_params, response.weather_data.temperatures[load_params[:point_index]].mint.time_layout)
    return nil if indexes.empty?
    if indexes.count == 0
      response.weather_data.temperatures[load_params[:point_index]].mint.value[indexes[0]].to_i
    else
      indexes.each_with_object([]) do |index, mints|
        mints << response.weather_data.temperatures[load_params[:point_index]].mint.value[index].to_i
      end.min
    end
  end

  def self.get_cloud_cover(response, load_params = {})
    indexes = param_indexes(response, load_params, response.weather_data.cloud_covers[load_params[:point_index]].time_layout)
    return nil if indexes.empty?
    raise WeatherLoaderError, "Unhandled multiple cloud cover times" if indexes.count > 1
    response.weather_data.cloud_covers[load_params[:point_index]].value[indexes[0]].to_i
  end

  def self.get_icon_link(response, load_params = {})
    indexes = param_indexes(response, load_params, response.weather_data.conditions_icons[load_params[:point_index]].time_layout)
    return nil if indexes.empty?
    raise WeatherLoaderError, "Unhandled multiple icon link times" if indexes.count > 1
    response.weather_data.conditions_icons[load_params[:point_index]].icon_link[indexes[0]]
  end

  def self.param_indexes(response, load_params, param_time_layout)
    load_params[:time_value].each_with_object([]) do |hash, indexes|
      hash.each do |key, value|
        layout = param_time_layout
        indexes << value if layout == key
      end
    end
  end

  def self.insert_weather!(response, load_params = {})
    weather_condition = response.weather_data
                                .weather[load_params[:point_index]]
                                .weather_conditions[load_params[:indexes][0]]
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

  def self.insert_or_return_weather_type_id!(weather_type)
    row = WeatherType.where(weather_type: weather_type).first
    if row.nil?
      wt = WeatherType.new
      wt.weather_type = weather_type
      wt.save!
      wt.id
    else
      row[:id]
    end
  end
end