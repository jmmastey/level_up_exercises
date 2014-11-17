class AddSendReminderToUser < ActiveRecord::Migration
  def change
    add_column :users, :send_reminder, :boolean
  end
end
