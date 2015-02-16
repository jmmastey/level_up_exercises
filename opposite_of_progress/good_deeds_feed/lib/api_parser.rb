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
      #bill.slice("congress", "urls", "official_title", "sponsor", "introduced_on")
      {
        congress_number: bill["congress"],
        congress_url: bill["urls"]["congress"],
        official_title: bill["official_title"],
        sponsor_title: bill["sponsor"]["title"],
        sponsor_firstname: bill["sponsor"]["first_name"],
        sponsor_lastname: bill["sponsor"]["last_name"],
        introduced_on: bill["introduced_on"]
      }
    end
  end

  def find_legislator(state)
    response = self.class.get("/legislators?per_page=50&state=#{state}")
    response["results"].map do |legislator|
      legislator.slice("birthday", "facebook_id", "gender", "first_name", 
        "last_name", "state_name", "term_start", "term_end", "title", "website")
    end
  end

end

  

api = CongressApiParser.new
#puts api.bills
puts api.bills
# puts api.bills
#puts response.message
#puts response.headers.inspect