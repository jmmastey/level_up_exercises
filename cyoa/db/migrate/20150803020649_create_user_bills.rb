class CreateUserBills < ActiveRecord::Migration
  def change
    create_table :user_bills do |t|
      t.integer :user_id
      t.integer :bill_id

      t.timestamps null: false
    end
  end
end
