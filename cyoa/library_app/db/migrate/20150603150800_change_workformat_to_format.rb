class ChangeWorkformatToFormat < ActiveRecord::Migration
  def change
    rename_column :books, :work_format, :format
  end
end
