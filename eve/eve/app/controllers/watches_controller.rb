class WatchesController < ApplicationController
  load_and_authorize_resource

  before_action :set_watch, only: [:show, :edit, :update, :destroy]
  respond_to :html, :xml, :json

  def index
    set_watches
    respond_with(@watches)
  end

  def show
    respond_with(@watch)
  end

  def new
    @watch = Watch.new(user: current_user)
    respond_with(@watch)
  end

  def edit
    respond_with(@watch)
  end

  def create
    Watch.create!(watch_params)
    respond_with(@watch)
  end

  def update
    @watch.update(watch_params)
    respond_with(@watch)
  end

  def destroy
    @watch.destroy
    respond_with(@watch)
  end

  private

  def set_watches
    @watches = Watch.where(user: current_user)
  end

  def set_watch
    @watch = Watch.find(params[:id])
  end

  def watch_params
    params.require(:watch).permit(:nickname, :item_id, :user_id, { regions: [] })
  end
end
