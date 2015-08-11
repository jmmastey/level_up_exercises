class RemoveUnusedColumnsBill < ActiveRecord::Migration
  def change
    remove_column :bills, :last_action_type, :string
    remove_column :bills, :last_action_text, :string
  end
end
