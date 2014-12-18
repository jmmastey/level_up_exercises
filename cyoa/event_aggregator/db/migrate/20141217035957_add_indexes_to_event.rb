class AddIndexesToEvent < ActiveRecord::Migration
  def change
    change_table :events do |t|
      t.index :event_hash, unique: true
      t.index :start_time
      t.index :end_time
      t.index :family_hash
    end
  end
end
