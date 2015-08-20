class AddListingToChannels < ActiveRecord::Migration
  def change
    add_column :channels, :listing, :integer
  end
end
