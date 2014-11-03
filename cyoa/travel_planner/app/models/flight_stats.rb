require 'rest_client'

class FlightStats
  APPLICATION_ID = "89cd457c"
  APPLICATION_KEY = "be2705cf426fe89bd49cbf1534d10978"
  HOST = "api.flightstats.com"

  def scheduled_flights(from, to, arrival)
  #   build our request
    RestClient::Request.execute(method: :get, url: "https://#{HOST}/flex/schedules/rest/v1/json/from/#{from}/to/#{to}/arriving/#{rest_date(arrival)}",
                                headers: { "appId" => "#{APPLICATION_ID}",
                                           "appKey" => "#{APPLICATION_KEY}"},
                                verify_ssl: false)
  end

  def rest_date(arrival)
    sprintf("%04d/%02d/%02d", arrival.year, arrival.month, arrival.day)
  end
end