require 'rest-client'

class ForecastWorker
  include Sidekiq::Worker

  def perform
    configuration = YAML.load_file('config/forecast_models.yaml')
    Location.zip_codes.each { |zip_code| save(configuration, zip_code) }
  end

  private

  def save(configuration, zip_code)
    configuration.each do |model, config|
      dwml = get_dwml(config['request_url'],
        request_parameters(config['request_parameters'],
          zip_code))
      forecasts = build_forecasts(dwml, config['request_fields'])
      save_model(model, valid_forecasts(forecasts, config), zip_code)
    end
  end

  def save_model(model, forecasts, zip_code)
    create_models(model.constantize, forecasts, zip_code)
  end

  def get_dwml(url, parameters)
    html = RestClient.get(url, params: parameters)
    DwmlParser.new(Nokogiri::XML(html))
  rescue => e
    logger.warn("Failed to get data for zip_code #{zip_code} " \
                "with status #{e.message}")
    nil
  end

  def request_parameters(static_parameters, zip_code)
    dynamic_request_parameters(zip_code).merge(static_parameters)
  end

  def dynamic_request_parameters(zip_code)
    {
      begin: Time.zone.now.iso8601,
      zipCodeList: zip_code,
    }
  end

  def build_forecasts(dwml, data_fields)
    data_fields.each_with_object(Hash.new({})) do |fields, hash|
      dwml.values(fields).each do |key, value|
        hash[key] = hash[key].merge(value)
      end
    end
  end

  def valid_forecasts(forecast_data, config)
    forecast_data.select do |time, forecast|
      forecast['temperature'].present? &&
        time[:date_time] < (Time.now + config.fetch("max_days", 1).to_i.days)
    end
  end

  def create_models(model, forecast_data, zip_code)
    forecast_data.each do |values|
      create_model(model, values, zip_code)
    end
  end

  def create_model(model, forecast_data, zip_code)
    time, values = forecast_data
    forecast = model.find_or_create_by(time: time[:date_time],
      zip_code: zip_code)
    forecast.update_attributes(values)
  end
end
