require 'rest-client'

class BaseForecastWorker
  include Sidekiq::Worker

  def perform
    Location.zip_codes.each { |zip_code| save(zip_code) }
  end

  private

  def find_or_create_model(time, values, zip_code, dwml)
    raise NotImplementedError, "find_or_create_model is required"
  end

  def request_url
    raise NotImplementedError, "request_url is required"
  end

  def request_parameters(zip_code)
    raise NotImplementedError, "request_parameters are required"
  end

  def data_fields
    raise NotImplementedError, "data_fields are required"
  end

  def save(zip_code)
    html = RestClient.get(request_url, params: request_parameters(zip_code))
    xml = Nokogiri::XML(html)
    dwml = DwmlParser.new(xml)
    build_forecasts(dwml, zip_code)
  end

  def build_forecasts(dwml, zip_code)
    build_data(dwml).each do |time, values|
      save_forecast(dwml, time, values, zip_code)
    end
  end

  def build_data(dwml)
    data_fields.each_with_object(Hash.new({})) do |fields, hash|
      dwml.values(fields).each do |key, value|
        hash[key] = hash[key].merge(value)
      end
    end
  end

  def save_forecast(dwml, time, values, zip_code)
    forecast = find_or_create_model(time, values, zip_code, dwml)
    if forecast
      forecast.update_attributes(values)
      forecast.save
    end
  end
end
