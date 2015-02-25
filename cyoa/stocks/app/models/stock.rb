class Stock < ActiveRecord::Base
  include StocksHelper

  has_many :stocks_users
  has_many :users, through: :stocks_users
  before_update :calculate_rating

  def to_param
    "#{symbol}"
  end

  def converted_ticker
    trend_rating = quantify_trend

    if trend_rating > 0
      '+' + trend_rating.to_s
    else
      trend_rating
    end
  end

  private

  def calculate_rating
    self.rating = calculate_rating_helper
  end

  def quantify_trend
    ticker_trend.scan('+').length - ticker_trend.scan('-').length
  end
end
