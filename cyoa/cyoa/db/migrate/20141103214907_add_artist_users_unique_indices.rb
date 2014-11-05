class AddArtistUsersUniqueIndices < ActiveRecord::Migration
  def change
    add_index :artists_users, [:artist_id, :user_id], unique: true
    add_index :artists_users, [:user_id, :artist_id], unique: true

    add_index :artists, :nbs_id, unique: true

    add_index :metrics, [:artist_id, :service_id, :category_id]
  end
end
