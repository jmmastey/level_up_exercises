require 'rest-client'

class BaseForecastWorker
  include Sidekiq::Worker
  DEFAULT_ZIP_CODE = 60606

  def perform
    zip_codes.each { |zip_code| save(forecast_xml(zip_code), zip_code: zip_code) }
  end

  private
  
  def request_url
    raise NotImplementedError, "request_url needs to be implemented"
  end

  def base_request_parameters
    raise NotImplementedError, "base_request_parameters needs to be implemented"
  end

  def zip_codes
    User.uniq.pluck(:zip_code) | [DEFAULT_ZIP_CODE]
  end

  def forecast_xml(zip_code)
    data = raw_data(zip_code)
    if data.include?("error")
      logger.warn("Failed to get info: #{data}")
    else
      Nokogiri::XML(data)
    end
  rescue => e
    logger.warn("Failed to get hourly forecast data for zip code #{zip_code} " \
                "with status #{e.message}")
    nil
  end

  def raw_data(zip_code)
    RestClient.get(request_url, params: request_parameters(zip_code))
  end

  def request_parameters(zip_code)
    base_request_parameters.merge({ begin: Time.zone.now.iso8601, 
                                    zipCodeList: zip_code })
  end

  def build_forecasts(parameters = {})
    raise NotImplementedError, "build_forecasts needs to be implemented"
  end

  def save(xml, options={})
    return unless xml
    @xml = xml
    build_forecasts(options).each { |time, forecast| forecast.save }
  end

  def data
    xml.at_xpath('/dwml/data')
  end

  def generate_time_map
    data.xpath('time-layout').each_with_object({}) do |time, hash|
      hash[time.xpath('layout-key').text] = get_time_layout_rows(time)
    end
  end

  def get_time_layout_rows(time)
    time.xpath('start-valid-time').map do |t|
      {
        period: t['period-name'],
        date_time: DateTime.parse(t.text),
      }
    end
  end

  def time_map
    @time_map ||= generate_time_map
  end

  def parameters
    @parameters ||= data.at_xpath('parameters')
  end

  def head
    @head ||= xml.at_xpath('/dwml/head')
  end

  def xml
    @xml
  end

  def get_data(forecasts, attribute, model_attribute, value_path='value', &filter)
    data = get_worker(attribute, value_path, filter) do |value, time|
      if value.text.present? && 
          (!@time_limit || time[:date_time] <= @time_limit)
        forecasts[time][model_attribute] = value.text
      end
    end
  end

  def get_attribute(forecasts, attribute, model_attribute, value_path='value',
                    value_attribute, &filter)
    get_worker(attribute, value_path, filter) do |value, time|
      if value.key?(value_attribute) && 
          (!@time_limit || time[:date_time] <= @time_limit)
        forecasts[time][model_attribute] = value[value_attribute]
      end
    end
  end

  def get_worker(attribute, value_path, filter, &block)
    filter ||= Proc.new { |d| d.first }
    data = parameters.xpath(attribute).detect(&filter)
    data.xpath(value_path).zip(time_map[data['time-layout']], &block)
  end
end
