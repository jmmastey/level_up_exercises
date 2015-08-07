class RemoveColumnListingFromChannel < ActiveRecord::Migration
  def change
    remove_column :channels, :listing
  end
end
