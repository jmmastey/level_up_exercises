class ChangeDelayTypeToTime < ActiveRecord::Migration
  def change
    change_column :scrape_times, :inter_scrape_delay, :time
  end
end
