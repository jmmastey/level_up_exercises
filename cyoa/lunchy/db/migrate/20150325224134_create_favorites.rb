class CreateFavorites < ActiveRecord::Migration
  def change
    create_table :favorites do |t|
      t.string :venue_id
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
