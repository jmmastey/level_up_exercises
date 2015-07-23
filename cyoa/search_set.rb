require './search.rb'
require './search_iterator.rb'

class SearchSet < SearchIterator
  attr_accessor :searches

  def initialize(queries: [''], limit: 20)
    @page_number = 0
    @original_queries = queries
    @searches = queries.map do |search_query|
      Search.new(query: search_query, limit: limit / queries.count )
    end
    aggregate_searches
  end

  def aggregate_searches
    @posts = @searches.inject([]) do |posts, search|
      posts += search.posts
    end
    @posts.shuffle!
  end

  def next_page?
    @searches.any?(&:next_page?)
  end

  def prev_page?
    @searches.any?(&:prev_page?)
  end

  def to_s
    str = "#<SearchSet: queries='#{@original_queries}' "
    str << "#{}results=#{@posts.count} "
    str << "next_page?=#{next_page?} "
    str << "prev_page?=#{prev_page?}>"
  end

  private

  def change_page(to: 'next')
    if to == 'next'
      @searches.each(&:next_page)
    else
      @searches.each(&:prev_page)
    end
    aggregate_searches
  end
end
