require_relative 'show.rb'
require_relative 'rc_iterator.rb'
require 'httparty'
require 'json'

class Search < RCIterator
  include HTTParty
  base_uri "http://www.reddit.com"

  attr_accessor :limit

  def initialize(query: '', limit: 5)
    @after, @before = '', ''
    @limit = limit
    @listing_number = 0

    @original_queries = [query]
    @api_query = "site:youtube.com #{query}"
    search
  end

  def next_listing?
    @after != ''
  end

  def prev_listing?
    @before != ''
  end

  def to_s
    str = "#<Search: query='#{@original_queries[0]}' "
    str << "results=#{@listings.count} "
    str << "next_listing?=#{next_listing?} "
    str << "prev_listing?=#{prev_listing?}>"
  end

  private

  def change_listing(to: 'next')
    search(next_or_prev: to)
    current_listing
  end

  def search(depth = 10, next_or_prev: 'next')
    raise "Could not connect to Reddit." if depth == 0

    response = self.class.get("/search.json", query: search_params(next_or_prev))
    if response && response['data']
      parse_response(response['data'])
    else
      puts "GOING DEEPER..."
      search(depth - 1) 
    end
  end

  def search_params(next_or_prev)
    http_params = { q: @api_query, limit: @limit }

    if next_or_prev == 'next'
      http_params[:after] = @after
    else
      http_params[:before] = @before
    end

    http_params
  end

  def parse_response(json_response)
    @after = json_response['after']
    parse_before_link(json_response)

    @listings = json_response['children'].map do |child| 
      Show.new(child['data']) 
    end
  end

  def parse_before_link(json_response)
    if @listing_number == 0
      @before = ''
    elsif json_response['children'].count == 0
      @before = ''
    else
      first_post = json_response['children'][0]
      @before = first_post['data']['before']
    end
  end
end


# RedditSearch.new('smite isis gameplay').list
