class MakeFieldsNonNull < ActiveRecord::Migration
  def change
    change_column :tweets, :tweet_id, :decimal, precision: 18, null: false
    change_column :tweets, :author, :string, limit: 50, null: false
    change_column :tweets, :tweet, :string, limit: 140, null: false
    change_column :tweets, :latitude, :decimal, precision: 10, scale: 6, null: false
    change_column :tweets, :longitude, :decimal, precision: 10, scale: 6, null: false
    change_column :tweets, :tweet_created_at, :datetime, null: false
  end
end
