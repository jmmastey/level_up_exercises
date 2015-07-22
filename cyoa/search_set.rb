require './reddit_search.rb'

class SearchSet
  include Enumerable

  LIMIT = 5
  attr_accessor :reddit_searches, :aggregate_posts, :original_queries

  def initialize(queries)
    @original_queries = queries
    @reddit_searches = queries.map do |query|
      puts "Searching for #{query}..."
      RedditSearch.new(query, limit: LIMIT)
    end
    aggregate_searches
  end

  def aggregate_searches
    @aggregate_posts = @reddit_searches.inject([]) do |posts, search|
      posts += search.posts
    end
    @aggregate_posts.shuffle!
  end

  def next_page
    @reddit_searches.each do |search|
      search.next_page
    end
    aggregate_searches
  end

  def more_results?
    @reddit_searches.any?(&:more_results?)
  end

  def each(&block)
    @aggregate_posts.each(&block)
  end

  def list
    each_with_index do |post, idx|
      next if post.nsfw?
      puts "[ #{idx} ] #{post}"
    end
  end

  def to_s
    str = "#<SearchSet: #queries='#{@original_queries}' "
    str << "results=#{@aggregate_posts.count} "
    str << "more_results?=#{more_results?}>"
  end

  def inspect
    to_s
  end
end
