class ChangeTweetColumnName < ActiveRecord::Migration
  def change
    rename_column :tweets, :tweet, :tweet_text
  end
end
