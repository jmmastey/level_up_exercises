class AddSlugToRealms < ActiveRecord::Migration
  def change
    add_column :realms, :slug, :string
  end
end
