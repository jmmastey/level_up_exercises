class AddFavoriteAndRecentRoutesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :favorite_routes, :string
    add_column :users, :recent_routes, :string
  end
end
