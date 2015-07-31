module RedditCast
  class Channel < RCIterator
    
    attr_accessor :name, :now_showing

    def initialize(json_channel)
      @name = json_channel['name']
      @original_queries = json_channel['queries']
      @listing_number = 0

      puts "Creating channel #{@name}-----"
      limit = 10#2 * @original_queries.count
      @listings = SearchSet.new(queries: @original_queries, limit: limit)
    end

    def now_showing
      current_listing
    end

    def next_show
      next_listing
    end

    def prev_show
      prev_listing
    end

    def next_listing?
      end_of_page = @listing_number == listings.count
      has_next_page = @listings.next_listing?

      !end_of_page || has_next_page
    end

    def prev_listing?
      @listing_number != 0
    end

    def next_listing
      return unless next_listing?

      @listing_number += 1
      if @listing_number == @listings.count
        @listings.next_listing
        @listing_number = 0
      end
      
      current_listing
    end

    def prev_listing
      return unless prev_listing?

      @listing_number -= 1
      if @listing_number == -1
        @listings.prev_listing
        @listing_number = @listings.count - 1
      end

      current_listing
    end

    def to_s
      "#<Channel: name='#{@name}' now_showing=#{now_showing}>"
    end
  end
end