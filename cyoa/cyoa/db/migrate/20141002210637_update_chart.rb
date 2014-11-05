class UpdateChart < ActiveRecord::Migration
  def change
    remove_column :charts, :song_id
    remove_column :charts, :position
    add_column :charts, :service_id, :integer
    add_column :charts, :type, :string
    add_column :charts, :recorded_on, :datetime
  end
end
