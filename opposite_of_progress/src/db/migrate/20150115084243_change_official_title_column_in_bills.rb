class ChangeOfficialTitleColumnInBills < ActiveRecord::Migration
  def up
    change_column :bills, :official_title, :text, limit: nil
  end

  def down
    change_column :bills, :official_title, :string
  end
end
