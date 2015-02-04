class CreateForecasts < ActiveRecord::Migration
  def change
    create_table :forecasts do |t|
      t.integer  :point_id,    null: false, foreign_key: true
      t.datetime :start_time,  null: false
      t.datetime :end_time,    null: false
      t.integer  :maxt,        null: true
      t.integer  :mint,        null: true
      t.integer  :cloud_cover, null: true
      t.string   :icon_link,   null: true,  limit: 255
      t.timestamps             null: false
    end
    ActiveRecord::Base.connection.execute("ALTER TABLE forecasts ALTER start_time TYPE timestamptz")
    ActiveRecord::Base.connection.execute("ALTER TABLE forecasts ALTER end_time TYPE timestamptz")
    add_index :forecasts, [:start_time, :end_time], unique: true
  end
end
