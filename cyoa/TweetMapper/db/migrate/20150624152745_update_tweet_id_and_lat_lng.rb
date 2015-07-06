class UpdateTweetIdAndLatLng < ActiveRecord::Migration
  def change
    change_column :tweets, :tweet_id, :numeric
    change_column :tweets, :latitude, :decimal, precision: 10, scale: 6
    change_column :tweets, :longitude, :decimal, precision: 10, scale: 6
  end
end
