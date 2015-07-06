class AddTweetCreatedAtToTweets < ActiveRecord::Migration
  def change
    add_column :tweets, :tweet_created_at, :datetime
  end
end
