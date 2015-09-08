class AddFundTypeToFunds < ActiveRecord::Migration
  def change
    add_column :funds, :fund_type, :string
  end
end
