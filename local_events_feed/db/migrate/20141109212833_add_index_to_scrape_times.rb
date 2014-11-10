class AddIndexToScrapeTimes < ActiveRecord::Migration
  def change
    add_index :scrape_times, :source, :unique => true
  end
end
