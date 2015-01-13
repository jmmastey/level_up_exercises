class FeedsController < ApplicationController
  before_action :set_feed, only: [:show, :edit, :update, :destroy]
  before_action :authorize_feed, only: [:edit, :update, :destroy]
  respond_to :html

  PERMITTED_PARAMS = [:title, :description]

  def index
    @custom_feeds = my_feeds
    @public_feeds = Feed.public_feeds
  end

  def show
    respond_with(@feed)
  end

  def new
    @feed = Feed.new;
    respond_with(@feed)
  end

  def edit
  end

  def create
    @feed = Feed.new(feed_params.merge({ user_id: current_user.id }))
    @feed.save
    if @feed.errors.blank?
      redirect_to(edit_feed_path(@feed))
    else
      respond_with(@feed)
    end
  end

  def update
    @feed.update(feed_params)
    respond_with(@feed)
  end

  def destroy
    @feed.destroy
    respond_with(@feed)
  end

  private

  def set_feed
    @feed = Feed.find(params[:id])
  end

  def feed_params
    params.require(:feed).permit(PERMITTED_PARAMS)
  end

  def my_feeds
    Feed.where(user: current_user)
  end

  def authorize_feed
    unless @feed.user == current_user
      render "public/403", layout: false, status: :forbidden 
    end
  end
end
