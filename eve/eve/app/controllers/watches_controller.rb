class WatchesController < ApplicationController
  before_action :set_watch, only: [:show, :edit, :update, :destroy]
  respond_to :html, :xml, :json

  def index
    @watches = Watch.all
    respond_with(@watches)
  end

  def show
    respond_with(@watch)
  end

  def new
    @watch = Watch.new
    respond_with(@watch)
  end

  def edit
  end

  def create
    @watch = Watch.new(watch_params)
    @watch.save
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
    def set_watch
      @watch = Watch.find(params[:id])
    end

    def watch_params
      params.require(:watch).permit(:nickname, :item_id, :user_id)
    end
end
