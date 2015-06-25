class AddThumbnailurlColToBook < ActiveRecord::Migration
  def change
    add_column :books, :thumbnail_url, :string
  end
end
