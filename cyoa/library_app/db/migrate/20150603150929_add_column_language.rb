class AddColumnLanguage < ActiveRecord::Migration
  def change
    add_column :books, :language, :string
  end
end
