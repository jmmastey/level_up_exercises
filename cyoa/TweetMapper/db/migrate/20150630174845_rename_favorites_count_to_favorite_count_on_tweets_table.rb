class RenameFavoritesCountToFavoriteCountOnTweetsTable < ActiveRecord::Migration
  def change
    rename_column :tweets, :favorites_count, :favorite_count
  end
end
