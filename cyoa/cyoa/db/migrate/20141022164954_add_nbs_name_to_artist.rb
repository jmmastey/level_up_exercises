class AddNbsNameToArtist < ActiveRecord::Migration
  def change
    add_column :artists, :nbs_name, :string
  end
end
