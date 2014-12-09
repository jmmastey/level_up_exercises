class AddBiographyNationalityBirthdayBlurbThumbnailToArtist < ActiveRecord::Migration
  def change
    add_column :artists, :biography, :text
    add_column :artists, :nationality, :string
    add_column :artists, :birthday, :date
    add_column :artists, :analysis, :text
    add_column :artists, :thumbnail, :string
  end
end
