class AddColumnsToBillsTable < ActiveRecord::Migration
  def change
    add_column :bills, :enacted_as, :string
    add_column :bills, :latest_version_pdf, :string
  end
end
