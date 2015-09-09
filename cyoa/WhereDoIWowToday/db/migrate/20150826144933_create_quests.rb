class CreateQuests < ActiveRecord::Migration
  def change
    create_table :quests do |t|
      t.integer :blizzard_id_num
      t.string :title
      t.string :category
      t.integer :req_level
      t.integer :level

      t.timestamps null: false
    end
    add_index :quests, :blizzard_id_num, unique: true
  end
end
