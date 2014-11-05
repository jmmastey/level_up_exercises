class IndexTables < ActiveRecord::Migration
  def change
    add_index :metrics, :recorded_on
    add_index :metrics, :artist_id
    add_index :metrics, :category_id
    add_index :services, :name
    add_index :categories, :name
    add_index :artists, :name
  end
end
