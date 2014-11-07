require 'active_support/all'
require 'rest_client'
require 'json'
require 'flight_stats/local_time'

module FlightStats
  class Schedule
    include LocalTime

    APPLICATION_ID  = "89cd457c"
    APPLICATION_KEY = "be2705cf426fe89bd49cbf1534d10978"
    HOST            = "api.flightstats.com"

    def get_flights_arriving_before(time, from, to)
      get_scheduled_flights(url(from, to, "arriving", time)).select! do |f|
        f["arrivalTime"].to_datetime < strip_timezone(time)
      end
    end

    def get_flights_departing_after(time, from, to)
      get_scheduled_flights(url(from, to, "departing", time)).select! do |f|
        f["departureTime"].to_datetime > strip_timezone(time)
      end
    end

    private

    def get_scheduled_flights(url)
      json = RestClient::Request.execute(method:     :get,
                                  url:        url,
                                  headers:    headers,
                                  verify_ssl: false)
      JSON.parse(json)["scheduledFlights"]
    end

    def headers
      {
        "appId"  => APPLICATION_ID,
        "appKey" => APPLICATION_KEY
      }
    end

    def url(from, to, action, date)
      "https://#{HOST}/flex/schedules/rest/v1/json/from/#{from}/to/#{to}/#{action}/#{url_date(date)}"
    end

    def url_date(date)
      sprintf("%04d/%02d/%02d", date.year, date.month, date.day)
    end
  end
end