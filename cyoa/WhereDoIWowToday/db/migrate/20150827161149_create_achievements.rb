class CreateAchievements < ActiveRecord::Migration
  def change
    create_table :achievements do |t|
      t.integer :blizzard_id_num
      t.string :title
      t.integer :faction_id

      t.timestamps null: false
    end
    add_index :achievements, :blizzard_id_num, unique: true
  end
end
