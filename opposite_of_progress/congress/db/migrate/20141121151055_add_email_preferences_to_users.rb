# Add email preferences to users
class AddEmailPreferencesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :email_preferences, :boolean
  end
end
