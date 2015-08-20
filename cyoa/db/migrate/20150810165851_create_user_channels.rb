class CreateUserChannels < ActiveRecord::Migration
  def change
    create_table :user_channels do |t|

      t.timestamps null: false
      t.integer :user_id
      t.integer :channel_id
    end
  end
end
