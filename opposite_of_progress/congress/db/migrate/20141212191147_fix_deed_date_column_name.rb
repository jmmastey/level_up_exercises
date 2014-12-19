class FixDeedDateColumnName < ActiveRecord::Migration
  def change
    rename_column :deeds, :date, :occurrence_date
  end
end
