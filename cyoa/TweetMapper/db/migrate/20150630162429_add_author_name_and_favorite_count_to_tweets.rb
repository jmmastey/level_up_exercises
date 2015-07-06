class AddAuthorNameAndFavoriteCountToTweets < ActiveRecord::Migration
  def change
    Tweet.delete_all
    rename_column :tweets, :author, :author_screen_name
    add_column :tweets, :author_name, :string, limit: 50, null: false
    add_column :tweets, :favorites_count, :integer, null: false, default: 0
    change_column :tweets, :retweet_count, :integer, null: false, default: 0
  end
end
