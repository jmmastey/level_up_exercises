require 'json'
require './channel.rb'

class RedditCast
  attr_accessor :channels, :current_channel

  def initialize
    channel_information = open('channels.json', &:read)
    parsed = JSON.parse(channel_information)

    @channels = parsed['channels'].map do |json_channel|
      Channel.new(json_channel)
    end
    @current_channel = 0
  end

  def channel_up
    @current_channel = (@current_channel + 1) % @channels.count
    puts "Channel is now #{channel}"
  end

  def channel_down
    @current_channel = (@current_channel - 1) % @channels.count
    puts "Channel is now #{channel}"
  end

  def channel
    @channels[@current_channel]
  end

  def skip_show
    @channels[@current_channel].show_next
  end
end