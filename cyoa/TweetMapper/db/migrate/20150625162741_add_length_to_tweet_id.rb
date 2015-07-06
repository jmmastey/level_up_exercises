class AddLengthToTweetId < ActiveRecord::Migration
  def change
    change_column :tweets, :tweet_id, :decimal, precision: 18
  end
end
