class RenameColumns < ActiveRecord::Migration
  def change
    rename_column :tweets, :tweet, :tweet_text
    rename_column :tweets, :tweet_id, :tweet_id_from_twitter
  end
end
