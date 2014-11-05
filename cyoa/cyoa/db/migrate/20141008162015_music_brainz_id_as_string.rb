class MusicBrainzIdAsString < ActiveRecord::Migration
  def change
    remove_column :artists, :music_brainz_id
    add_column :artists, :music_brainz_id, :string
  end
end
