class AddUserIdToFunds < ActiveRecord::Migration
  def change
    add_column :funds, :user_id, :integer
  end
end
