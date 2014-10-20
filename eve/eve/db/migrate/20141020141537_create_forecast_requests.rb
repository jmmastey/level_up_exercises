class CreateForecastRequests < ActiveRecord::Migration
  def change
    create_table :forecast_requests do |t|
      t.date :target_date
      t.integer :num_target_days
      t.datetime :history_start_time
      t.datetime :history_end_time
      t.decimal :min_price
      t.decimal :average_price
      t.decimal :max_price
      t.belongs_to :item

      t.timestamps null: false
    end

    add_index :forecast_requests, :target_date
    add_index :forecast_requests, :item_id
  end
end
