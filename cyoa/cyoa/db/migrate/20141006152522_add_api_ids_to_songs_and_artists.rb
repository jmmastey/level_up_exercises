class AddApiIdsToSongsAndArtists < ActiveRecord::Migration
  def change
    add_column :artists, :grooveshark_id, :integer
    add_column :artists, :nbs_id, :integer
    add_column :songs, :grooveshark_id, :integer
  end
end
