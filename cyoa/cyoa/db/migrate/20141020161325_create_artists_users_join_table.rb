class CreateArtistsUsersJoinTable < ActiveRecord::Migration
  def change
    create_table :artists_users, id: false do |t|
      t.integer :artist_id
      t.integer :user_id
    end
  end
end
