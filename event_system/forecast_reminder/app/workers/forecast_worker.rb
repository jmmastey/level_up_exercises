require 'rest-client'

class ForecastWorker
  include Sidekiq::Worker

  def perform(zip_code = nil)
    configuration = YAML.load_file('config/forecast_models.yaml')
    zip_codes = zip_code ? [zip_code] : Location.zip_codes
    zip_codes.each { |zip| save(configuration, zip) }
  end

  private

  def save(configuration, zip_code)
    configuration.each do |model, config|
      dwml = get_dwml(config['request_url'],
        request_parameters(config['request_parameters'], zip_code))
      forecasts = build_forecasts(dwml, config['request_fields'])
      create_models(model.constantize, valid_forecasts(forecasts, config),
        zip_code)
    end
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
    return unless dwml
    data_fields.each_with_object(Hash.new({})) do |fields, hash|
      dwml.values(fields).each do |key, value|
        hash[key] = hash[key].merge(value)
      end
    end
  rescue => e
    logger.warn("Failed to build forecast with error #{e.message}")
    {}
  end

  def valid_forecasts(forecast_data, config)
    forecast_data.select do |time, forecast|
      forecast['temperature'].present? &&
        time < config.fetch("max_days", 1).to_f.days.from_now
    end
  end

  def create_models(model, forecast_data, zip_code)
    forecast_data.each do |time, values|
      model.find_or_create_by(time: time, zip_code: zip_code)
        .update_attributes(values)
    end
  end
end
