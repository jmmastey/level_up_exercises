class AddOfficialIdColumnToBillsTable < ActiveRecord::Migration
  def change
    add_column :bills, :official_id, :string
  end
end
