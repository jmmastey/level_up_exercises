require "nws/forecast"
require "nws/dwml_parser"
require "uri"
require "open-uri"

module NWS
  class RestService
    SERVICE_HOST = "graphical.weather.gov"
    SERVICE_PATH = "/xml/sample_products/browser_interface/ndfdBrowserClientByDay.php"

    def self.forecast_by_zip_code(zip_code, options = {})
      forecast_xml = retrieve_forecast(zip_code, options[:days])
      parser = DWMLParser.new(forecast_xml)
      Forecast.new(zip_code, parser.periods_with_predictions) 
    end

    private

    def self.retrieve_forecast(zip_code, days)
      uri = build_uri({
        "zipCodeList" => zip_code,
        "format" => "12 hourly",
        "startDate" => Time.new.strftime("%Y-%m-%d"),
        "numDays" => days,
        "Unit" => "e"
      })
      uri.read
    end

    def self.build_uri(query)
      URI::HTTP.build({
        host: SERVICE_HOST,
        path: SERVICE_PATH,
        query: build_query_string(query)
      })
    end

    def self.build_query_string(query)
      query.map do |name, value|
        URI.escape(name.to_s) + "=" + URI.escape(value.to_s)
      end.join "&"
    end
  end
end
