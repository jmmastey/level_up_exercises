class ChangeTransactionHowPaidToInteger < ActiveRecord::Migration
  def change
    remove_column :transactions, :how_paid
    add_column :transactions, :how_paid, :integer
  end
end
