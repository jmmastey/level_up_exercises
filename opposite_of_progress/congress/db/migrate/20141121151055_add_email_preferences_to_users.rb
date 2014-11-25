class AddEmailPreferencesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :email_preferences, :boolean
  end
end
