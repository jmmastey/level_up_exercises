class ChangeTransactionTypeColumn < ActiveRecord::Migration
  def change
    remove_column :transactions, :type
    add_column :transactions, :transaction_type, :string
  end
end
