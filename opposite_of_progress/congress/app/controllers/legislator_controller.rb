class LegislatorController < ApplicationController
  def fetch_all
    http = Curl.get("https://congress.api.sunlightfoundation.com/legislators?last_name=Brown&apikey=2d3136f6874046c8ba34d5e2f1a96b03")
    @results = JSON.parse(http.body_str)
  end
end
