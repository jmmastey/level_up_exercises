module WorkerHelpers
  def build_forecasts
    raise NotImplementedError, "build_forecasts needs to be implemented"
  end

  def save(xml)
    @time_map = get_time_map(xml)
    @parameters = get_parameters(xml)
    @head = get_base_head(xml)
    build_forecasts.each { |time, forecast| forecast.save }
  end
  
  def get_time_map(xml)
    get_base_data(xml).xpath('time-layout').each_with_object({}) do |time, hash|
      hash[time.xpath('layout-key').text] = get_time_layout_rows(time)
    end
  end

  def get_parameters(xml)
    get_base_data(xml).at_xpath('parameters')
  end

  def get_base_data(xml)
    xml.at_xpath('/dwml/data')
  end

  def get_base_head(xml)
    xml.at_xpath('/dwml/head')
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
    @time_map
  end

  def parameters
    @parameters
  end

  def head
    @head
  end

  def get_data(forecasts, attribute, model_attribute, value_path='value', &filter)
    data = get_worker(attribute, model_attribute, value_path, filter) do |value, time|
      if value.text.present? && 
          (!@time_limit || time[:date_time] <= @time_limit)
        forecasts[time][model_attribute] = value.text
      end
    end
  end

  def get_attribute(forecasts, attribute, model_attribute, value_path='value',
                    value_attribute, &filter)
    get_worker(attribute, model_attribute, value_path, filter) do |value, time|
      if value.key?(value_attribute)
          forecasts[time][model_attribute] = value[value_attribute]
      end
    end
  end

  def get_worker(attribute, model_attribute, value_path, filter, &block)
    filter ||= Proc.new { |d| d.first }
    data = parameters.xpath(attribute).detect(&filter)
    data.xpath(value_path).zip(time_map[data['time-layout']], &block)
  end
end
