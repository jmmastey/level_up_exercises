class RedditCastController < ApplicationController

  def next_show
    session[:save_channel] = true
    session[:channel].next_show
    render json: locals
  end

  def prev_show
    session[:save_channel] = true
    session[:channel].prev_show
    render json: locals
  end

  def next_channel
    save_channel if session[:save_channel]
    session[:channel_idx]  = (session[:channel_idx] + 1) % session[:channels].count
    session[:channel] = channel
    render json: locals
  end

  def prev_channel
    save_channel if session[:save_channel]
    session[:channel_idx]  = (session[:channel_idx] - 1) % session[:channels].count
    session[:channel] = channel
    render json: locals
  end

  def to_channel
    save_channel if session[:save_channel]
    session[:channel] = Channel.find_by_name(params[:name])
    session[:channel_idx] = session[:channels].index(session[:channel].id)
    render json: locals
  end

  def now_showing
    render json: locals
  end

  def index
    session[:channels] = Channel.ids
    session[:channel_idx] = 0
    session[:channel] = channel
    @channels = Channel.all
    @locals = locals
  end

  private

  def locals
    { 
      channel_name: channel_name, 
      channel_number: channel_number, 
      show_id: show_id,
      show_name: show_name
    }
  end

  def save_channel
    session[:channel].search_set.searches.each(&:save)
    session[:channel].search_set.save
    session[:channel].save
  end

  def channel
    Channel.find(session[:channels][session[:channel_idx]])
  end

  def channel_name
    session[:channel].name
  end

  def channel_number
    num = session[:channel_idx] + 1
    "#{num < 10 ? '0' : ''}#{num}"
  end

  def show_id
    session[:channel].now_showing.youtubeid
  end

  def show_name
    session[:channel].now_showing.short_title
  end
end
