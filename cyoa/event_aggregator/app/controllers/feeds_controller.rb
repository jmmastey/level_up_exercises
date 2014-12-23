class FeedsController < ApplicationController
  before_action :set_feed, only: [:show, :edit, :update, :destroy]

  respond_to :html

  PERMITTED_PARAMS = [:owner_user_id, :title, :description, :public]

  def index
    @feeds = Feed.all
    respond_with(@feeds)
  end

  def show
    respond_with(@feed)
  end

  def new
    @feed = Feed.new
    respond_with(@feed)
  end

  def edit
  end

  def create
    @feed = Feed.new(feed_params)
    @feed.save
    respond_with(@feed)
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
end
