class RemoveLocationFromTransactions < ActiveRecord::Migration
  def change
    remove_column :transactions, :location
  end
end
