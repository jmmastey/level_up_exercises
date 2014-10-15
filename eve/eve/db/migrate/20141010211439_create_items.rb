class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name
      t.integer :in_game_id

      t.timestamps null: false
    end
  end
end
