require 'rubygems'
require 'active_support'
require 'HTTParty'
class CongressApiParser
  include HTTParty
  base_uri 'congress.api.sunlightfoundation.com'
  default_params apikey: '23b3ee3083ea405dbb84c2b3476efcd6'
  def initialize
  end

  def bills
    response = self.class.get("/bills/search?history.enacted=true&per_page=50&order=introduced_on")
    response["results"].map do |bill|
      {
        "congress_number" => bill["congress"],
        "congress_url" => bill["urls"]["congress"],
        "official_title" => bill["official_title"],
        "introduced_on" => bill["introduced_on"],
        "bioguide_id" => bill["sponsor_id"]
      }
    end
  end

  def find_legislator(state)
    response = self.class.get("/legislators?per_page=50&bioguide_id=R000487")
    response["results"].map do |legislator|
      legislator#.slice("birthday", "facebook_id", "gender", "first_name", 
        #{}"last_name", "state_name", "term_start", "term_end", "title", "website")
    end.sample
  end

end

api = CongressApiParser.new
#puts api.bills
#puts "\n\n\n\n"
#puts api.find_legislator("WY")
