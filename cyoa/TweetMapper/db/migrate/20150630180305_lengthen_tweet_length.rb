class LengthenTweetLength < ActiveRecord::Migration
  def change
    change_column :tweets, :tweet_text, :string, limit: 255
  end
end
