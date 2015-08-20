class CreateShows < ActiveRecord::Migration
  def change
    create_table :shows do |t|
      t.string :title
      t.string :youtubeid
      t.integer :channel_id

      t.timestamps null: false
    end
  end
end
