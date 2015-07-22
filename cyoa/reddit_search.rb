require './post.rb'
require 'httparty'
require 'json'

class RedditSearch
  include Enumerable
  include HTTParty
  base_uri "http://www.reddit.com"

  attr_accessor :posts, :query, :original_query, :limit

  def initialize(query="", limit: 5)
    @after, @before = '', ''
    @limit = limit
    @post_offset = 0

    @original_query = query
    @query = "site:youtube.com #{query}"
    search
  end

  def more_results?
    !!@after
  end

  def next_page
    if more_results?
      @post_offset += @posts.count
      search
    else
      @posts = []
    end
  end

  def each(&block)
    @posts.each(&block)
  end

  def list
    each_with_index do |post, idx|
      next if post.nsfw?
      puts "[ #{idx + @post_offset} ] #{post}"
    end
  end

  def to_s
    str = "#<RedditSearch: Query='#{@original_query}' "
    str << "results=#{@posts.count} "
    str << "more_results?=#{more_results?}>"
  end

  def inspect
    to_s
  end

  private

  def parse_response(json_response)
    @after = json_response['after']
    @before = json_response['before']

    @posts = json_response['children'].map do |child| 
      Post.new(child['data']) 
    end
  end

  def search
    http_params = { q: @query, limit: @limit, after: @after}

    response = self.class.get("/search.json", query: http_params)
    search unless response

    parse_response(response['data'])
  end
end


# RedditSearch.new('smite isis gameplay').list
