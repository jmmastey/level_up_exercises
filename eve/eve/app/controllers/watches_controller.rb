class WatchesController < ApplicationController
  load_and_authorize_resource

  before_action :set_watch, only: [:show, :edit, :update, :destroy]
  before_action :set_watches, only: :index
  respond_to :html, :xml, :json

  def new
    @watch = Watch.new(user: current_user)
    respond_with(@watch)
  end

  def create
    @watch = Watch.new(watch_params)
    if @watch.save
      redirect_to @watch
    else
      render :new
    end
  end

  def update
    @watch.update(watch_params)
    respond_with(@watch)
  end

  def destroy
    @watch.destroy
    respond_with(@watch)
  end

  def show
    respond_to do |format|
      format.html { redirect_to watches_path(anchor: "watch-#{@watch.id}") }
      format.json
      format.xml
    end
  end

  private

  def watches
    Watch.where(user: current_user)
         .order(:nickname)
  end

  def set_watches
    @watches = watches.includes(:item, :region, :station)
  end

  def set_watch
    @watch = watches.find(params[:id])
  end

  def watch_params
    params.require(:watch).permit(:nickname,
                                  :item_id,
                                  :user_id,
                                  :region_id,
                                  :station_id)
  end
end
