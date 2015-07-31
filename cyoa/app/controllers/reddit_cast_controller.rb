class RedditCastController < ApplicationController

  def show

  end

  def index
    # session[:tv] ||= RedditCast::TV.new
    tv = Rails.cache.fetch(:tv) do |tv|
      RedditCast.new
    end
    @channel_name = tv.channel.name
  end
end
