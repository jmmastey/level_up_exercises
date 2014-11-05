class AddPositionToChartSongs < ActiveRecord::Migration
  def change
    add_column :chart_songs, :position, :integer
  end
end
