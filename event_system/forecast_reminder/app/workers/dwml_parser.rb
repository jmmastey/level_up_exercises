class DwmlParser
  attr_reader :xml, :time_map

  def initialize(xml)
    @xml = xml
    @time_map = generate_time_map
  end

  def values(attribute: String, map_name: Symbol, value_path: 'value',
             type: nil)
    data = data_xpath(attribute, type)
    values = data.xpath(value_path)
    values.each_with_index.each_with_object({}) do |(value, index), hash|
      hash[time_map[data['time-layout']][index]] = { map_name => value.text }
    end
  end

  def data_xpath(attribute, type)
    parameters_xml
      .xpath(attribute)
      .detect { |d| type.nil? || d['type'] == type }
  end

  def request_time
    request_time = xml.at_xpath('/dwml/head/product/creation-date').text
    DateTime.parse(request_time)
  end

  private

  def parameters_xml
    xml.at_xpath('/dwml/data/parameters')
  end

  def time_layout_xml
    xml.xpath('/dwml/data/time-layout')
  end

  def generate_time_map
    time_layout_xml.each_with_object({}) do |time, hash|
      hash[time.xpath('layout-key').text] = get_time_layout_row(time)
    end
  end

  def get_time_layout_row(time)
    time.xpath('start-valid-time').map do |t|
      {
        period: t['period-name'],
        date_time: DateTime.parse(t.text),
      }
    end
  end
end
