class AddMetricTypeColumn < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name

      t.timestamps
    end

    remove_column :metrics, :json_data
    remove_column :metrics, :start_on
    remove_column :metrics, :end_on
    add_column :metrics, :value, :integer
    add_column :metrics, :nbs_date, :string
    add_column :metrics, :category_id, :integer
  end
end
