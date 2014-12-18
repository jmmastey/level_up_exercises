class CreateFeeds < ActiveRecord::Migration
  def change
    create_table :feeds do |t|
      t.integer :owner_user_id
      t.string :title, limit: 128
      t.text :description, limit: 2048
      t.boolean :public, default: false

      t.timestamps
    end
  end
end
