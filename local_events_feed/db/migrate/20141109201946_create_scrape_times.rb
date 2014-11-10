class CreateScrapeTimes < ActiveRecord::Migration
  def change
    create_table :scrape_times do |t|
      t.string :source
      t.datetime :last_trigger_at
      t.datetime :inter_scrape_delay

      t.timestamps
    end
  end
end
