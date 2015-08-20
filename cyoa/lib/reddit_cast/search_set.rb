module RedditCast
  class SearchSet < RCIterator
    LIMIT = 20
    attr_accessor :searches

    def initialize(search_set: nil, queries: [""])
      if !!search_set
        init_from_model(search_set)
      else
        init_from_http(queries)
      end

      @listings = []
      aggregate_searches
    end

    def aggregate_searches
      new_listings = @searches.inject([]) do |listings, search|
        listings + search.listings
      end
      new_listings.shuffle!
      @listings += new_listings
    end

    def original_queries
      @searches.inject([]) do |queries, search| 
        queries + search.original_queries
      end
    end

    def next_listing?
      @searches.any?(&:next_listing?)
    end

    def prev_listing?
      @searches.any?(&:prev_listing?)
    end

    def to_s
      str = "#<SearchSet: queries='#{original_queries}' "
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

    def init_from_model(search_set)
      @listing_number = search_set.listing

      limit = LIMIT / search_set.searches.count
      @searches = search_set.searches.map do |search|
        RedditCast::Search.new(search: search, limit: limit)
      end
    end

    def init_from_http(queries)
      @listing_number = 0

      limit = LIMIT / queries.count
      @searches = queries.map do |search_query|
        RedditCast::Search.new(query: search_query, limit: limit)
      end
    end
  end
end
