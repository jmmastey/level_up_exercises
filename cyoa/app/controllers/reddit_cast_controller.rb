class RedditCastController < ApplicationController

  def next_show
    session[:tv].channel.next_show
    render json: locals
  end

  def prev_show
    session[:tv].channel.prev_show
    render json: locals
  end

  def next_channel
    session[:tv].channel_up
    render json: locals
  end

  def prev_channel
    session[:tv].channel_down
    render json: locals
  end

  def now_showing
    render json: locals
  end

  def index
    session[:tv] ||= RedditCast::TV.new(channels: Channel.all)
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

  def channel_name
    session[:tv].channel.name
  end

  def channel_number
    session[:tv].channel_number
  end

  def show_id
    session[:tv].channel.now_showing.youtubeid
  end

  def show_name
    session[:tv].channel.now_showing.short_title
  end

  def load_next_search_page
    limit = RedditCast::SearchSet::LIMIT
    num_queries = session[:tv].channel.original_queries.count
    real_limit = (limit / num_queries) * num_queries;

    if session[:tv].channel.listing_number % real_limit == 0
      puts "++++++++ LOADING NEXT PAGE +++++++"
      TVWorker.perform_async(session[:tv], 1)
    end
  end
end
