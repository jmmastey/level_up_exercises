class ChangeOfficialTitleColumnInBills < ActiveRecord::Migration
  def change
    change_column :bills, :official_title, :text
  end
end
