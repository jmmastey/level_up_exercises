class CreateUserTags < ActiveRecord::Migration
  def change
    create_table :user_tags do |t|
      t.integer :user_id, null: false
      t.integer :tag_id, null: false

      t.timestamps null: false
    end
  end
end
