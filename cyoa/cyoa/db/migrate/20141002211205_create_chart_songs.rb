class CreateChartSongs < ActiveRecord::Migration
  def change
    create_table :chart_songs do |t|
      t.integer :chart_id
      t.integer :song_id
      t.integer :popularity

      t.timestamps
    end
  end
end
