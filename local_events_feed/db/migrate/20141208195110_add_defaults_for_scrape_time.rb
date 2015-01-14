class AddDefaultsForScrapeTime < ActiveRecord::Migration
  def change
    change_column_default(:scrape_times, :inter_scrape_delay, Time.at(86400))
    change_column_default(:scrape_times, :last_scrape_at, Time.at(0))
  end
end
