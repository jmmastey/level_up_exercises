class CreateUserContactNotifications < ActiveRecord::Migration
  def change
    create_table :user_contact_notifications do |t|

      t.timestamps null: false
    end
  end
end
