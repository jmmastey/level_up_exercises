class AddServiceToMetricTable < ActiveRecord::Migration
  def change
    add_column :metrics, :service_id, :integer
  end
end
