class CreateUserNotifications < ActiveRecord::Migration
  def change
    create_table :user_notifications do |t|
      
      t.timestamps null: false
    end
  end
end
