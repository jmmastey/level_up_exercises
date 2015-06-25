class ChangeOclcnumToOclc < ActiveRecord::Migration
  def change
    rename_column :books, :oclc_num, :oclc
  end
end
