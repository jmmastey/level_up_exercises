class StocksController < ApplicationController
  before_action :set_stock, only: [:show]

  def index
    @stocks = Stock.all
  end

  def show
    raise ArgumentError, "Stock does not exist!" unless @stock

    response = YahooFinance.historical_quotes(@stock.symbol,
      start_date: Time.now - (24 * 60 * 60 * 365), end_date: Time.now)
    @data = response.map { |r| [r.trade_date, r.open.to_f] }
  end

  private

  def set_stock
    @stock = Stock.find_by_symbol(params[:id])
  end
end
