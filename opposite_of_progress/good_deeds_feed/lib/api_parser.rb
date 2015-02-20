require 'rubygems'
require 'active_support'
require 'HTTParty'
class CongressApiParser
  include HTTParty
  base_uri 'congress.api.sunlightfoundation.com'
  default_params apikey: '23b3ee3083ea405dbb84c2b3476efcd6'
  def initialize
  end

  def bills(page)
    response = self.class.get("/bills/search?history.enacted=true&per_page=50&order=introduced_on&page=#{page.to_i}")
    response["results"].map do |bill|
      {
        "congress_number" => bill["congress"],
        "congress_url" => bill["urls"]["congress"],
        "official_title" => bill["official_title"],
        "introduced_on" => bill["introduced_on"],
        "bioguide_id" => bill["sponsor_id"],
        "short_title" => bill["short_title"]
      }
    end
  end
end

api = CongressApiParser.new
#puts api.bills(2).count
#puts "\n\n\n\n"
#puts api.find_legislator("WY")
