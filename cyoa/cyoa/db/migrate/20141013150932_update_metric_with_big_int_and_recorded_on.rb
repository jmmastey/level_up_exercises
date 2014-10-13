class UpdateMetricWithBigIntAndRecordedOn < ActiveRecord::Migration
  def up
    change_column :metrics, :value, :bigint
    add_column :metrics, :recorded_on, :date
  end

  def down
    change_column :metrics, :value, :integer
  end
end
