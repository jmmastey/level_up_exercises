class AddColumnsToBillAction < ActiveRecord::Migration
  def change
    add_column :bill_actions, :result, :string
    add_column :bill_actions, :chamber, :string
  end
end
