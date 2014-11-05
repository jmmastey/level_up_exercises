class CreateArtistSlugs < ActiveRecord::Migration
  def change
    add_column :artists, :slug, :string
    add_index :artists, :slug, unique: true
  end
end
