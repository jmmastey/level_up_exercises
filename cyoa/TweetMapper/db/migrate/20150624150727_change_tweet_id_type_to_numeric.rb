class ChangeTweetIdTypeToNumeric < ActiveRecord::Migration
  def change
    change_column :tweets, :tweet_id, :decimal, precision: 10, scale: 6
  end
end
