class AddApiidToArtists < ActiveRecord::Migration
  def change
    add_column :artists, :api_id, :string
  end
end
