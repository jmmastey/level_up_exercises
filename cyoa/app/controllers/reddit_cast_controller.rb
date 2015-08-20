class RedditCastController < ApplicationController
  before_action :authenticate_user!

  def next_show
    if(session[:channel_count] != 0)
      channel.next_show
      save_channel
    end
    render json: locals
  end

  def prev_show
    if(session[:channel_count] != 0)
      channel.prev_show
      save_channel
    end
    render json: locals
  end

  def next_channel
    if(session[:channel_count] == 0)
      session[:channel] = 0
    else
      session[:channel]  = (session[:channel] + 1) % session[:channel_count]
    end
    render json: locals
  end

  def prev_channel
    if(session[:channel_count] == 0)
      session[:channel] = 0
    else
      session[:channel]  = (session[:channel] - 1) % session[:channel_count]
    end
    render json: locals
  end

  def to_channel
    puts "\nSEARCHING FOR CHANNEL #{params[:name]}\n"
    if(session[:channel_count] == 0)
      session[:channel] = 0
    else
      session[:channel] = current_user.channels.index do |ch|
        ch.name == params[:name]
      end    
    end
    render json: locals
  end

  def now_showing
    render json: locals
  end

  def index
    session[:channel] = 0
    @channels = current_user.channels
    session[:channel_count] = @channels.count
    @locals = locals
  end

  private

  def locals
    if(session[:channel_count] != 0)
      { 
        channel_name: channel_name, 
        channel_number: channel_number, 
        show_id: show_id,
        show_name: show_name,
        index: session[:channel]
      }
    else 
      { 
        channel_name: "RedditCast", 
        channel_number: "00", 
        show_id: "",
        show_name: "Open the guide to create a channel",
        index: 0
      }
    end
  end

  def save_channel
    channel.search_set.searches.each(&:save)
    channel.search_set.save
  end

  def channel
    current_user.channels[session[:channel]]
  end

  def channel_name
    channel.name
  end

  def channel_number
    num = session[:channel] + 1
    "#{num < 10 ? '0' : ''}#{num}"
  end

  def show_id
    channel.now_showing.youtubeid
  end

  def show_name
    channel.now_showing.short_title
  end
end
