class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.integer :repeat_interval
      t.decimal :min_rating, :precision => 3, :scale => 1
      t.integer :max_distance
      t.references :user, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end
