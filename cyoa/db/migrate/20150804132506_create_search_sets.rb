class CreateSearchSets < ActiveRecord::Migration
  def change
    create_table :search_sets do |t|
      t.integer :listing
      t.integer :channel_id

      t.timestamps null: false
    end
  end
end
