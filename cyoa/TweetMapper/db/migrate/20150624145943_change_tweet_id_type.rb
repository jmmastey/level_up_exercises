class ChangeTweetIdType < ActiveRecord::Migration
  def change
    change_column :tweets, :tweet_id, :integer
  end
end
