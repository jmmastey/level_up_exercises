class ChangeChartTypeColumnToScope < ActiveRecord::Migration
  def change
    remove_column :charts, :type
    add_column :charts, :scope, :string
  end
end
