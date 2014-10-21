class CreateJoinTableRegionWatch < ActiveRecord::Migration
  def change
    create_join_table :regions, :watches do |t|
      t.index [:region_id, :watch_id]
      t.index [:watch_id, :region_id]
    end
  end
end
