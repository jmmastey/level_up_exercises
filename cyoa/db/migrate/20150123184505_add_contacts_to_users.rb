class AddContactsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :phone, :string, { null: true, limit: 50 }
    change_column :users, :email, :string, { null: false, limit: 100 }
  end
end
