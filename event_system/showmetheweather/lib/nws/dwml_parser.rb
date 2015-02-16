require "nokogiri"

module NWS
  class DWMLParser
    def initialize(xml)
      @forecast = Nokogiri::XML(xml)
    end

    def periods_with_predictions
      parse_high_temps
      parse_low_temps
      parse_precipitation
      parse_conditions
      periods
    end

    private

    def time_layouts
      return @time_layouts if @time_layouts

      time_layouts = {}
      @forecast.xpath("//time-layout").each do |time_layout_element|
        key = time_layout_element.at_xpath("layout-key").text
        start_times = time_layout_element.xpath("start-valid-time")
        end_times = time_layout_element.xpath("end-valid-time")
        periods = []
        start_times.each_with_index do |start_time, i|
          next unless start_time.attributes["period-name"]
          periods << { start_time: start_time.text,
                       name: start_time.attributes["period-name"].text,
                       end_time: end_times[i].text }
        end
        time_layouts[key] = periods unless periods.empty?
      end
      @time_layouts = time_layouts
    end

    def periods
      return @periods if @periods

      periods = {}
      time_layouts.each_value do |time_layout|
        time_layout.each do |period|
          periods[period[:name]] ||= { start_time: period[:start_time],
                                       end_time: period[:end_time],
                                       predictions: {} }
        end
      end
      @periods = periods
    end

    def parse_high_temps
      parse_values("//temperature[@type='maximum']", "High Temperature")
    end

    def parse_low_temps
      parse_values("//temperature[@type='minimum']", "Low Temperature")
    end

    def parse_precipitation
      parse_values("//probability-of-precipitation", "Chance of Precipitation") 
    end

    def parse_values(xpath, label)
      element = @forecast.at_xpath(xpath)
      values = element.xpath("value")
      time_layout_key = element.attributes["time-layout"].text
      time_layout = time_layouts[time_layout_key]
      time_layout.each_with_index do |period, i|
        periods[period[:name]][:predictions][label] = values[i].text
      end
    end

    def parse_conditions
      conditions_element = @forecast.at_xpath("//weather")
      conditions_values = conditions_element.xpath("weather-conditions")
      time_layout_key = conditions_element.attributes["time-layout"].text
      time_layout = time_layouts[time_layout_key]
      time_layout.each_with_index do |period, i|
        next unless conditions_values[i].attributes["weather-summary"]
        periods[period[:name]][:predictions]["Conditions"] =
          conditions_values[i].attributes["weather-summary"].text
      end
    end
  end
end
