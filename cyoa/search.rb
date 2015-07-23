require './post.rb'
require './search_iterator.rb'
require 'httparty'
require 'json'

class Search < SearchIterator
  include HTTParty
  base_uri "http://www.reddit.com"

  attr_accessor :limit

  def initialize(query: '', limit: 5)
    @after, @before = '', ''
    @limit = limit
    @page_number = 0

    @original_queries = [query]
    @api_query = "site:youtube.com #{query}"
    search
  end

  def next_page?
    @after != ''
  end

  def prev_page?
    @before != ''
  end

  def to_s
    str = "#<RedditSearch: query='#{@original_queries[0]}' "
    str << "results=#{@posts.count} "
    str << "next_page?=#{next_page?} "
    str << "prev_page?=#{prev_page?}>"
  end

  private

  def change_page(to: 'next')
    search(page: to)
  end

  def search(depth = 10, page: 'next')
    raise "Could not connect to Reddit." if depth == 0

    response = self.class.get("/search.json", query: search_params(page))
    if response
      parse_response(response['data'])
    else
      search(depth - 1) 
    end
  end

  def search_params(page)
    http_params = { q: @api_query, limit: @limit }

    if page == 'next'
      http_params[:after] = @after
    else
      http_params[:before] = @before
    end

    http_params
  end

  def parse_response(json_response)
    @after = json_response['after']
    if @page_number == 0
      @before = ''
    else
      first_post = json_response['children'][0]
      @before = first_post['data']['before']
    end

    @posts = json_response['children'].map do |child| 
      Post.new(child['data']) 
    end
  end
end


# RedditSearch.new('smite isis gameplay').list
