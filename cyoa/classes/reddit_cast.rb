require 'json'
require_relative 'rc_iterator.rb'
require_relative 'channel.rb'

class RedditCast < RCIterator

  def initialize
    channel_information = open('channels.json', &:read)
    parsed = JSON.parse(channel_information)

    @listings = parsed['channels'].map do |json_channel|
      Channel.new(json_channel)
    end
    @listing_number = 0
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
end