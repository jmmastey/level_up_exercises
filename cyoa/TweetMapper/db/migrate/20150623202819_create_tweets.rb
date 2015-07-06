class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.decimal :tweet_id
      t.string :author
      t.string :tweet, limit: 140
      t.integer :retweet_count
      t.float :latitude, precision: 10, scale: 6
      t.float :longitude, precision: 10, scale: 6
      t.datetime :created_at
      t.timestamps null: false
    end
  end
end
