class ChangeLastTriggerAtToLastScrapeAt < ActiveRecord::Migration
  def change
    rename_column :scrape_times, :last_trigger_at, :last_scrape_at
  end
end
