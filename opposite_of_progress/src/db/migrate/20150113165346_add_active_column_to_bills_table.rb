class AddActiveColumnToBillsTable < ActiveRecord::Migration
  def change
    add_column :bills, :active, :boolean
  end
end
