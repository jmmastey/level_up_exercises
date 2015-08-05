module RedditCast
  class Channel < RCIterator
    
    attr_accessor :name, :now_showing

    def initialize(channel: nil, name: "", tags: [""])
      puts "Creating channel #{name || channel.name}-----"
      if !!channel
        init_from_model(channel)
      else
        init_from_http(name, tags)
      end
    end

    def original_queries
      @listings.original_queries
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
      end
      
      current_listing
    end

    def prev_listing
      return unless prev_listing?

      @listing_number -= 1
      current_listing
    end

    def to_s
      "#<Channel: name='#{@name}' now_showing=#{now_showing}>"
    end

    private

    def init_from_model(channel)
      @name = channel.name
      @listing_number = channel.search_set.listing
      @listings = RedditCast::SearchSet.new(search_set: channel.search_set)
    end

    def init_from_http(name, tags)
      @name = name
      @listing_number = 0
      @listings = RedditCast::SearchSet.new(queries: tags)
    end
  end
end