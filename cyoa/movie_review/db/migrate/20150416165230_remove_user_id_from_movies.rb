class RemoveUserIdFromMovies < ActiveRecord::Migration
  def change
    remove_column :movies, :user_id, :integer
  end
end
