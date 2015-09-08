class ChangeHowPaidNameInTransactions < ActiveRecord::Migration
  def change
    remove_column :transactions, :how_paid
    add_column :transactions, :fund_id, :integer
  end
end
