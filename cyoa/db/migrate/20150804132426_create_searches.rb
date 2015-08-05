class CreateSearches < ActiveRecord::Migration
  def change
    create_table :searches do |t|
      t.string :before
      t.string :after
      t.string :query
      t.integer :listing
      t.integer :search_set_id

      t.timestamps null: false
    end
  end
end
