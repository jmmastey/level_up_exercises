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
    HEADERS         = {
      "appId"  => "#{APPLICATION_ID}",
      "appKey" => "#{APPLICATION_KEY}"
    }
    ARRIVING        = "arriving"
    DEPARTING       = "departing"

    def arrive(before, from, to)
      flights = execute(url(from, to, ARRIVING, before))
      filter(flights, before, true)
    end

    def leave(after, from, to)
      flights = execute(url(from, to, DEPARTING, after))
      filter(flights, after, false)
    end

    private

    def filter(flights, on, before)
      flights.select! do |flight|
        flight_time = comparison_time(before, flight)
        if before
          flight_time < strip_timezone(on)
        else
          strip_timezone(on) < flight_time
        end
      end
      flights
    end

    def comparison_time(before, flight)
      if before
        time_key = "arrivalTime"
      else
        time_key = "departureTime"
      end
      DateTime.parse(flight[time_key])
    end

    def execute(url)
      puts "execute!"
      json = RestClient::Request.execute(method:     :get,
                                  url:        url,
                                  headers:    HEADERS,
                                  verify_ssl: false)
      JSON.parse(json)["scheduledFlights"]
    end

    def url(from, to, action, on)
      "https://#{HOST}/flex/schedules/rest/v1/json/from/#{from}/to/#{to}/#{action}/#{url_date(on)}"
    end

    def url_date(date)
      sprintf("%04d/%02d/%02d", date.year, date.month, date.day)
    end
  end
end