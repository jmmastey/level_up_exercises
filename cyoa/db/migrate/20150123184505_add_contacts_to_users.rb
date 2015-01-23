class AddContactsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :phone, :string, { null: true, limit: 50 }
    add_column :users, :email, :string, { null: true, limit: 100 }
  end
end
