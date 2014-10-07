class CreateMetrics < ActiveRecord::Migration
  def change
    create_table :metrics do |t|
      t.integer :artist_id
      t.json :json_data
      t.datetime :start_on
      t.datetime :end_on

      t.timestamps
    end
  end
end
