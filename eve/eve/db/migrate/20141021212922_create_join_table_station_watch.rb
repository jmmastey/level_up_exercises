class CreateJoinTableStationWatch < ActiveRecord::Migration
  def change
    create_join_table :stations, :watches do |t|
      t.index [:station_id, :watch_id]
      t.index [:watch_id, :station_id]
    end
  end
end
