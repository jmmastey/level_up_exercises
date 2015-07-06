class NewUniqueValues < ActiveRecord::Migration
  def change
    add_index :tweets, :tweet_id, unique: true
    add_index :sessions, :session_id, unique: true
  end
end
