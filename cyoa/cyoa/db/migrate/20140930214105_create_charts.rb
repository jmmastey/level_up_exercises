class CreateCharts < ActiveRecord::Migration
  def change
    create_table :charts do |t|
      t.integer :song_id
      t.integer :position

      t.timestamps
    end
  end
end
