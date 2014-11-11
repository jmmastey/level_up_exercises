require 'active_support/all'
require 'rest_client'
require 'json'
require 'flight_stats/local_time'
require 'flight_stats/url_builder'

module FlightStats
  class Schedule
    include LocalTime

    def get_flights_arriving_before(time, from, to)
      builder = FlightStats::UrlBuilder.new.from(from).to(to).date(time)
      get_scheduled_flights(builder.schedule_arriving_url).select! do |f|
        f["arrivalTime"].to_datetime < strip_timezone(time)
      end
    end

    def get_flights_departing_after(time, from, to)
      builder = FlightStats::UrlBuilder.new.from(from).to(to).date(time)
      get_scheduled_flights(builder.schedule_departing_url).select! do |f|
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
        "appId"  => "89cd457c",
        "appKey" => "be2705cf426fe89bd49cbf1534d10978"
      }
    end

  end
end
