require 'json'

module RedditCast
  class Search < RCIterator
    include HTTParty
    base_uri "http://www.reddit.com"

    attr_accessor :limit, :before, :after

    def initialize(search: nil, query: '', limit: 5)
      @limit = limit

      if !!search
        init_from_model(search)
      else
        init_from_http(query)
      end
    end

    def query
      @original_queries[0]
    end

    def next_listing?
      after != ''
    end

    def prev_listing?
      before != ''
    end

    def to_s
      str = "#<Search: query='#{query}' "
      str << "results=#{@listings.count} "
      str << "next=#{next_listing?} "
      str << "prev=#{prev_listing?}>"
    end

    private

    def api_query
      "site:youtube.com nsfw:no #{query}"
    end

    def init_from_model(search)
      @listing_number = search.listing
      @after = search.after || ''
      @before = search.before || ''
      @original_queries = [search.query]
      @listings = search.shows.map do |show|
        RedditCast::Show.new(show: show)
      end
    end

    def init_from_http(query)
      @after, @before = '', ''
      @listing_number = 0
      @original_queries = [query]
      search
    end

    def change_listing(to: 'next')
      search(next_or_prev: to) if next_listing?
      current_listing
    end

    def search(depth = 10, next_or_prev: 'next')
      raise "Could not connect to Reddit." if depth == 0

      response = self.class.get("/search.json", query: search_params(next_or_prev))
      if response && response['data']
        parse_response(response['data'])
      else
        search(depth - 1) 
      end
    end

    def search_params(next_or_prev)
      http_params = { q: api_query, limit: limit }

      if next_or_prev == 'next'
        http_params[:after] = after
      else
        http_params[:before] = before
      end

      http_params
    end

    def parse_response(json_response)
      @after = json_response['after']
      parse_before_link(json_response)

      @listings = json_response['children'].map do |child| 
        title = child['data']['title']
        url = child['data']['url']
        RedditCast::Show.new(title: title, url: url) 
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
end


# RedditSearch.new('smite isis gameplay').list
