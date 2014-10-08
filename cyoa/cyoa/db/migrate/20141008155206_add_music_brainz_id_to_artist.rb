class AddMusicBrainzIdToArtist < ActiveRecord::Migration
  def change
    add_column :artists, :music_brainz_id, :integer
  end
end
