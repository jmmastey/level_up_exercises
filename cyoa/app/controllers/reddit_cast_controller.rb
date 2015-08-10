class RedditCastController < ApplicationController
  before_action :authenticate_user!

  def next_show
    channel.next_show
    save_channel
    render json: locals
  end

  def prev_show
    channel.prev_show
    save_channel
    render json: locals
  end

  def next_channel
    session[:channel_idx]  = (session[:channel_idx] + 1) % session[:channels].count
    render json: locals
  end

  def prev_channel
    session[:channel_idx]  = (session[:channel_idx] - 1) % session[:channels].count
    render json: locals
  end

  def to_channel
    session[:channel_idx] = session[:channels].index do |ch|
      ch.name == params[:name]
    end
    render json: locals
  end

  def now_showing
    render json: locals
  end

  def index
    session[:channels] = current_user.channels
    session[:channel_idx] = 0
    @channels = session[:channels]
    @locals = locals
  end

  private

  def locals
    { 
      channel_name: channel_name, 
      channel_number: channel_number, 
      show_id: show_id,
      show_name: show_name,
      index: session[:channel_idx]
    }
  end

  def save_channel
    channel.search_set.searches.each(&:save)
    channel.search_set.save
  end

  def channel
    session[:channels][session[:channel_idx]]
  end

  def channel_name
    channel.name
  end

  def channel_number
    num = session[:channel_idx] + 1
    "#{num < 10 ? '0' : ''}#{num}"
  end

  def show_id
    channel.now_showing.youtubeid
  end

  def show_name
    channel.now_showing.short_title
  end
end
