class CreateAnimes < ActiveRecord::Migration
  def change
    create_table :animes do |t|
      t.integer :external_id, index: true
      t.string :status
      t.string :title, index: true
      t.integer :episode_count
      t.integer :episode_length
      t.string :cover_image
      t.string :synopsis
      t.string :show_type
      t.integer :community_rating

      t.timestamps null: false
    end
  end
end
