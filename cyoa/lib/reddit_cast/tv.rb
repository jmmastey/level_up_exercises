require 'json'

module RedditCast
  class TV < RCIterator
    def initialize(channels: nil, json_file: "channels.json")
      if !!channels
        init_from_db(channels)
      else
        init_from_json(json_file)
      end
    end

    def next_listing?
      true
    end

    def prev_listing?
      true
    end

    def next_listing
      @listing_number = (@listing_number + 1) % @listings.count
      current_listing
    end

    def prev_listing
      @listing_number = (@listing_number - 1) % @listings.count
      current_listing
    end

    def channel_down
      prev_listing
    end

    def channel_up
      next_listing
    end

    def channels
      @listings
    end

    def channel
      current_listing
    end

    def channel_number
      num = listing_number + 1
      "#{num < 10 ? '0' : ''}#{num}"
    end

    private

    def init_from_db(channels)
      @listings = channels.map do |channel|
        RedditCast::Channel.new(channel: channel)
      end
      @listing_number = 0
    end

    def init_from_json(json_file)
      channel_information = open(json_file, &:read)
      parsed = JSON.parse(channel_information)

      @listings = parsed['channels'].map do |json|
        RedditCast::Channel.new(name: json['name'], tags: json['queries'])
      end
      @listing_number = 0
    end
  end
end