class CreateUserBills < ActiveRecord::Migration
  def change
    create_table :user_bills do |t|
      t.integer :user_id, null: false
      t.integer :bill_id, null: false

      t.timestamps null: false
    end
  end
end
