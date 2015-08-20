class ChannelController < ApplicationController
  before_action :authenticate_user!
  
  def create
    # note: make sure to strip whitespace from each tag
    params[:tags].map! { |tag| tag.strip.downcase }

    NewChannelWorker.perform_async(params.merge({user: current_user.id}), 10)
  end

  def status
    ch = current_user.channels.where(name: params["name"])

    response = {}
    response['ready'] = (ch.count != 0)
    response['count'] = 0
    if response['ready']
      session[:channel_count] = current_user.channels.count 
      response['count'] = session[:channel_count]
    end
    render json: response
  end

  def destroy
    channel = current_user.channels.find_by_name(params[:name])
    user_channels = current_user.user_channels.where(channel_id: channel.id)
    user_channels.each(&:destroy)

    unless channel.default?
      channel.search_set.searches.each do |search|
        search.shows.each(&:destroy)
        search.destroy
      end
      channel.search_set.destroy
      channel.destroy 
    end

    session[:channel_count] = current_user.channels.count 
    session[:channel] = [session[:channel], session[:channel_count] - 1].min

    render json: {success: true}.to_json
  end
end