class CreateFriendRequests < ActiveRecord::Migration
  def change
    create_table :friend_requests do |t|
      t.references :from, references: :user
      t.references :to, references: :user
      t.string :message

      t.timestamps null: false
    end
  end
end
