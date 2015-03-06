require 'rubygems'
require 'active_support/all'
require 'httparty'

class CongressApiParser
  include HTTParty

  OK_STATUS_CODE = 200
  BILLS_PER_PAGE = 50
  BILL_KEYS = %w( congress urls official_title introduced_on sponsor_id
                  short_title )

  base_uri 'congress.api.sunlightfoundation.com'
  default_params apikey: '23b3ee3083ea405dbb84c2b3476efcd6'

  def initialize
  end

  def all_bills
    bills = []
    1.upto(number_of_pages) do |page|
      bills << bills_by_page(page)
    end
    bills.flatten
  end

  private

  def bills_by_page(page)
    raise ArgumentError unless page.is_a?(Fixnum) && page >= 1
    api_response = get_bills(page)
    raise ArgumentError unless api_response.code == OK_STATUS_CODE
    check_bill_format(api_response["results"])
    api_response["results"].map do |bill|
      parse(bill)
    end
  end

  def check_bill_format(api_data)
    api_data.each do |bill|
      raise ArgumentError unless BILL_KEYS.all? { |key| bill.key? key }
    end
  end

  def number_of_pages
    api_response = get_bills
    raise ArgumentError unless api_response.code == OK_STATUS_CODE
    (api_response['count'] / 50.0).ceil
  end

  def get_bills(page = 1)
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
