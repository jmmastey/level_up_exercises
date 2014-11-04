require 'rest_client'

class FlightStats
  APPLICATION_ID = "89cd457c"
  APPLICATION_KEY = "be2705cf426fe89bd49cbf1534d10978"
  HOST = "api.flightstats.com"
  HEADERS = {
    "appId"  => "#{APPLICATION_ID}",
    "appKey" => "#{APPLICATION_KEY}"
  }

  def scheduled_flights(from, to, arrival)
    execute(:get, schedule_url(arrival, from, to))
  end

  private

  def execute(method, url)
    RestClient::Request.execute(method:     method,
                                url:        url,
                                headers:    HEADERS,
                                verify_ssl: false)
  end

  def schedule_url(arrival, from, to)
    "https://#{HOST}/flex/schedules/rest/v1/json/from/#{from}/to/#{to}/arriving/#{url_date(arrival)}"
  end

  def url_date(arrival)
    sprintf("%04d/%02d/%02d", arrival.year, arrival.month, arrival.day)
  end
end