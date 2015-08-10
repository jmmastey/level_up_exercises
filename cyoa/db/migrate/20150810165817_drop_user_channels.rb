class DropUserChannels < ActiveRecord::Migration
  def change
    drop_table :user_channels
  end
end
