class CreateUserNotifications < ActiveRecord::Migration
  def change
    create_table :user_notifications do |t|
      t.integer :user_id,           null: false
      t.time    :notification_time, null: false
      t.boolean :active,            null: false, default: false
      t.timestamps                  null: false
    end
  end
end
