class CreateStocks < ActiveRecord::Migration
  def change
    create_table :stocks do |t|
      t.string :symbol
      t.string :name
      t.string :sector
      t.string :industry
      t.float :asking_price
      t.float :bid_price
      t.string :ticker_trend
      t.float :moving_average_200_day
      t.float :moving_average_50_day
      t.float :pe_ratio
      t.float :peg_ratio
      t.string :market_cap
      t.float :rating

      t.timestamps null: false
    end
  end
end
