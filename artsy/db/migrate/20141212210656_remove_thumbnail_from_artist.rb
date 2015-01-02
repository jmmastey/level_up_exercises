class RemoveThumbnailFromArtist < ActiveRecord::Migration
  def change
    remove_column :artists, :image_url
  end
end
