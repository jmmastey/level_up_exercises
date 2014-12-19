class FixBillEnactedAtColumnName < ActiveRecord::Migration
  def change
    rename_column :bills, :enacted_at, :enacted_on
  end
end
