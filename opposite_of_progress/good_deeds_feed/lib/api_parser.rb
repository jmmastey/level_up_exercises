require 'rubygems'
require 'active_support'
require 'httparty'
require 'webmock'

class CongressApiParser
  include HTTParty

  WebMock.disable!

  OK_STATUS_CODE = 200
  BILLS_PER_PAGE = 50

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

  def number_of_pages
    (get_bills(1)['count']/50.0).ceil
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
puts api.number_of_pages
#api.number_of_bills.each do |k, v|
#  p k
#  p v
#  puts "\n\n\n\n\n\n"
#end