require_relative 'search.rb'
require_relative 'rc_iterator.rb'

class SearchSet < RCIterator
  attr_accessor :searches

  def initialize(queries: [], limit: 10)
    @listing_number = 0
    @original_queries = queries

    @searches = queries.map do |search_query|
      sleep 2
      Search.new(query: search_query, limit: limit / queries.count )
    end
    aggregate_searches
  end

  def aggregate_searches
    @listings = @searches.inject([]) do |listings, search|
      listings + search.listings
    end
    @listings.shuffle!
  end

  def next_listing?
    @searches.any?(&:next_listing?)
  end

  def prev_listing?
    @searches.any?(&:prev_listing?)
  end

  def to_s
    str = "#<SearchSet: queries='#{@original_queries}' "
    str << "results=#{@listings.count} "
    str << "next_listing?=#{next_listing?} "
    str << "prev_listing?=#{prev_listing?}>"
  end

  private

  def change_listing(to: 'next')
    if to == 'next'
      @searches.each(&:next_listing)
    else
      @searches.each(&:prev_listing)
    end
    aggregate_searches
    current_listing
  end
end
