class RemoveUserIdFromTransactions < ActiveRecord::Migration
  def change
    remove_column :transactions, :user_id
  end
end
