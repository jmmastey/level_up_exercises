class CreateFriends < ActiveRecord::Migration
  def change
    create_table :friends do |t|
      t.references :user
      t.references :friend, references: :user

      t.timestamps null: false
    end
  end
end
