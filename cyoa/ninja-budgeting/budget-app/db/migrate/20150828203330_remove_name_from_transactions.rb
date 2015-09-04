class RemoveNameFromTransactions < ActiveRecord::Migration
  def change
    remove_column :transactions, :name
  end
end
