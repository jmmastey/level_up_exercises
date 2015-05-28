class ChangeColNameOwiToOclc < ActiveRecord::Migration
  def change
    rename_column :books, :owi_num, :oclc_num
  end
end
