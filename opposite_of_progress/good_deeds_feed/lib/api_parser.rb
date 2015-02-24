require 'rubygems'
require 'active_support'
require 'httparty'

class CongressApiParser
  include HTTParty

  OK_STATUS_CODE = 200

  base_uri 'congress.api.sunlightfoundation.com'
  default_params apikey: '23b3ee3083ea405dbb84c2b3476efcd6'

  def initialize
  end

  def all_bills

  end

  def bills_by_page(page)
    raise ArgumentError unless page.is_a?(Fixnum) && page >= 1
    api_response = get_bills(page)
    raise RuntimeError unless api_response.code == OK_STATUS_CODE
    api_response["results"].map do |bill|
      parse(bill)
    end
  end

  def number_of_bills
    #get_bills(1)["count"]
    get_bills(1)
  end
 # CHECK FOR MULTIPLE SPONSORS
  private

  def get_bills(page)
    bill_params = { query: { per_page: 50, page: page, order: "introduced_on" } }
    self.class.get("/bills/?history.enacted=true", bill_params)
  end

  def parse(bill)
    {
      congress_number: bill["congress"],
      congress_url: bill["urls"]["congress"],
      official_title: bill["official_title"],
      introduced_on: bill["introduced_on"],
      bioguide_id: bill["sponsor_id"],
      short_title: bill["short_title"],
    }
  end
end

api = CongressApiParser.new
# puts api.bills_by_page(1).count
#api.number_of_bills.each do |k, v|
#  p k
#  p v
#  puts "\n\n\n\n\n\n"
#end