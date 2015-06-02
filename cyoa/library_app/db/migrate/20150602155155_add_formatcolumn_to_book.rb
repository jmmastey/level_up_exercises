class AddFormatcolumnToBook < ActiveRecord::Migration
  def change
    add_column :books, :work_format, :string
  end
end
