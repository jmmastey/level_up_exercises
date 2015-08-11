class AddChannelToUser < ActiveRecord::Migration
  def change
    add_column :users, :last_channel, :integer
  end
end
