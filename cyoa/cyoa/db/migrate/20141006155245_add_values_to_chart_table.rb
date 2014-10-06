class AddValuesToChartTable < ActiveRecord::Migration
  def change
    add_column :charts, :raw_data, :json
  end
end
