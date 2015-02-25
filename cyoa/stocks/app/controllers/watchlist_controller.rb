class WatchlistController < ApplicationController
  before_action :set_stock, only: [:update]
  before_action :authenticate_user!, except: [:feed]

  def index
    @stocks = current_user.stocks
  end

  def update
    add_or_remove_stock(@stock)

    respond_to do |format|
      format.json { render json: "0".to_json }
    end
  end

  def feed
    user = User.find_by_id(params[:id])
    raise ArgumentError, "User Does Not Exist!" unless user
    @title = "Stocks I'm Watching"
    @watched_stocks = user.stocks.order("created_at desc")
    @updated = @watched_stocks.first.created_at unless @watched_stocks.empty?

    respond_to do |format|
      format.atom do
        headers["Content-Type"] = 'application/atom+xml; charset=utf-8'
        render layout: false
      end
      format.rss { redirect_to feed_path(format: :atom), status: :moved_permanently }
    end
  end

  private

  def set_stock
    @stock = Stock.find_by_symbol(params[:id])
    raise ArgumentError, "Stock Symbol Doesn't Exist!" unless @stock
  end

  def add_or_remove_stock(stock)
    if current_user.stocks.include?(stock)
      current_user.stocks.delete(stock)
    else
      current_user.stocks << stock
    end
  end
end
