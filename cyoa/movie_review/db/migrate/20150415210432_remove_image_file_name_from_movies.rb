class RemoveImageFileNameFromMovies < ActiveRecord::Migration
  def change
    remove_column :movies, :image_file_name, :string
    remove_column :movies, :image_content_type, :string
    remove_column :movies, :image_file_size, :string
    remove_column :movies, :image_updated_at, :string
  end
end
